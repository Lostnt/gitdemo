package lab

import java.sql.{Connection, DriverManager}
/**
  * Created by A chun on 2017/10/18.
  */
object DBUtils {
  val username = "root"
  val password = "123456"
  val url = "jdbc:mysql://127.0.0.1:1234/classschedule?useUnicode=true&characterEncoding=utf-8&useSSL=false"
  Class.forName("com.mysql.jdbc.Driver")

  def getConnection(): Connection = {
    DriverManager.getConnection(url, username, password)
  }
  def close(conn: Connection): Unit = {
    try {
      if (!conn.isClosed() || conn != null) {
        conn.close()
      }
    }
    catch {
      case ex: Exception => {
        ex.printStackTrace()
      }
    }
  }
}
