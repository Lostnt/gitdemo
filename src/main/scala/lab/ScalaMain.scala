package lab
import java.io.{File, FileInputStream, PrintWriter}
import java.util
import com.alibaba.fastjson.JSONObject
import org.apache.poi.ss.usermodel.{Cell, WorkbookFactory}

import scala.util.control.Breaks.{break, breakable}
class ScalaMain {
  /*
*主函数遍历文件夹，将文件夹中的文件传入解析函数analyzing中进行分析
 */
  def startAnalyze()= {
    var dir= "D:\\IntelliJ IDEA 2018.1.8\\workplace\\ClassSchedule\\src\\main\\webapp\\analyze\\"
    for(d <- subDir(new File(dir))) {
      breakable
      {
        if (d.getName.indexOf("~$")>=0)//缓存表跳过
          break
        analyzing(d.getAbsolutePath)
        d.delete()
      }

    }
  }

  def subDir(dir:File):Iterator[File] ={//文件遍历函数（工具函数）
    val dirs = dir.listFiles().filter(_.isDirectory())
    val files = dir.listFiles().filter(_.isFile())
    files.toIterator ++ dirs.toIterator.flatMap(subDir _)
  }

  def analyzing(filepath:String):Unit=
  {//打开excel文件
    val inputStream = new FileInputStream(filepath)
    val wb = WorkbookFactory.create(inputStream)
    val sheet = wb.getSheetAt(0)
    var filetype=""
    var filename=""
    var filecode=""
    //获得标题
    var title=sheet.getRow(0).getCell(0).toString
    //分析文件，得到类型和文件名
    if (title.indexOf("教室")>=0)
    {
      filetype="classroom"
      filename=title.substring(0,title.indexOf("教室"))
      title=sheet.getRow(1).getCell(0).getStringCellValue
      filecode=title.substring(5,title.indexOf(" "))
    }
    else if (title.indexOf("老师")>=0)
    {
      filetype="teacher"
      filename=title.substring(0,title.indexOf("老师"))
      title=sheet.getRow(1).getCell(0).getStringCellValue
      filecode=title.substring(6,title.indexOf(" "))
    }
    else if (title.indexOf("班级")>=0 )
    {
      filetype="class"
      title=sheet.getRow(1).getCell(0).toString
      filename=title.substring(title.indexOf("班级名称")+5,title.indexOf("("))
      filecode=title.substring(title.indexOf("班级代码")+5,title.length)
    }

    val jsonObject = new JSONObject()
    var weekNum = Array(" ","one", "two", "three","four","five" ,"six" ,"seven" ,"eight" ,"nine", "ten",
      "eleven" ,"twelve" ,"thirteen" ,"fourteen" ,"fifteen" ,"sixteen" ,"seventeen", "eighteen")
    for (i <- 2 to 8)//周一至周日
    {
      val jsonObjects = new JSONObject()
      val week=sheet.getRow(2).getCell(i)//周几
      for(j <- 3 to 7)//第一二节到第九十节
      {
        var c = sheet.getRow(j).getCell(i)//单元格
        breakable {
          var time=sheet.getRow(j).getCell(1).getStringCellValue.replace("\n","")//第几节
          var content = ""
          var classtime: List[Int] = List()
          if (c == null || c.getCellType == Cell.CELL_TYPE_BLANK)//空的单元格跳过
          {
            content=" "
            classtime=classtime
          }else{
            content=c.getStringCellValue.replace(" ","")//内容
            classtime=analyzingContent(content)//需要上课周的列表
          }
          /*          var name=content.split("◇")(0)//课程名称（精简版，如果有需要）
                    println(filename)
                    println(week)
                    println(time.substring(1,3))
                    println(content)
                    println(classtime)
                    println(classtime.contains(1))*/

          var list:util.ArrayList[Any] = new util.ArrayList[Any]()
          var map = new util.HashMap[String,Any]()
          for(k <- 1 to 18){
              if(classtime.contains(k)){
                content = "有课"
              }else{
                content =  " "
              }
            map.put(weekNum(k),content)
          }
          jsonObjects.put(time.substring(1,3),map)
        }
      }
      jsonObject.put(""+week,jsonObjects)

    }
    val jsonString = jsonObject.toJSONString
    val conn = DBUtils.getConnection()
    try {
      var sql=""
      if(filetype == "classroom"){
        sql = "INSERT INTO classroom(selectType,lessonInfo)VALUES(?, ?)"
      }else if(filetype == "class"){
        sql = "INSERT INTO class(selectType,lessonInfo)VALUES(?, ?)"
      }else if(filetype == "teacher"){
        sql = "INSERT INTO teacher(selectType,lessonInfo)VALUES(?, ?)"
      }

      val pstm = conn.prepareStatement(sql.toString())
      pstm.setString(1,filename)
      pstm.setString(2, jsonString)
      pstm.executeUpdate()
    }
    finally {
      conn.close()
    }
  }
  /*
  *
  *解析内容，从内容中得到需要上课的周列表
  */
  def analyzingContent(content:String):List[Int]=
  {
    if(content.indexOf("借用")>=0)//周六借用的课，只有第七周
    {
      return List(7)
    }

    var sp=content.split("◇")
    var name=sp(0)//课程名
    var listStr=sp(1)//需要上课周的列表字符串
    var x=0
    if ((name.indexOf("大学英语")>=0) || (name.indexOf("大学日语")>=0))//大学英语和日语的格式不一样
    {
      listStr=sp(2)
    }
    var wstart = -1
    var wend = -1
    var deletestart = -1
    var deleteend = -1
    var deleteword=""
    if(listStr.indexOf("2节/")>=0)
    {
      wstart = listStr.indexOf("(")
      wend = listStr.indexOf(")")
    }
    if (listStr.indexOf("双") >= 0)
      x = 2
    if (listStr.indexOf("单") >= 0)
      x = 1
    if (wstart >= 0)
      listStr = listStr.substring(wstart + 1,wend)
    else
    {
      //删除没用的上课时间
      deletestart = listStr.indexOf("(")
      deleteend = listStr.indexOf(")")
      if(deletestart >= 0)
      {
        deleteword = listStr.substring(deletestart,deleteend + 1)
        listStr = listStr.replace(deleteword, "")
      }
    }


    if(listStr.indexOf("双")>=0)
    {
      listStr=listStr.replace("双","")
      x = 2
    }
    if(listStr.indexOf("单") >= 0)
    {
      listStr = listStr.replace("单", "")
      x = 1
    }
    return  getweeklist(listStr, x)
  }

  def getweeklist(w:String,x:Int):List[Int]=
  {
    var wlist: List[Int] = List()//需要上课的周列表
  var sp=w.split(",")
    var start = -1
    var end = -1
    for(word <- sp)
    {
      if (word.indexOf("-")>=0)
      {
        start=word.substring(0,word.indexOf("-")).toInt
        end=word.substring(word.indexOf("-")+1,word.length).toInt
        for(i <- start to end)
        {
          wlist=i::wlist
        }
      }
      else
      {
        wlist=word.toInt::wlist
      }
    }
    var tlist: List[Int] = List()//临时列表
    if(x == 2)
    {
      for (i <- wlist)
      {
        if(i % 2 == 0)
        {

          tlist=i::tlist
        }
      }
    }
    else if(x == 1)
    {
      for (i <- wlist)
      {
        if(i % 2 != 0)
        {
          tlist=i::tlist
        }
      }
    }
    else if(x == 0)
    {
      tlist=wlist
    }
    wlist=tlist
    wlist=wlist.sorted
/*
    var result=""
    for(w <- wlist)
    {
      result=w.toString+","+result
    }
    result=result.substring(0,result.length-1)
*/

    return wlist
  }
}
