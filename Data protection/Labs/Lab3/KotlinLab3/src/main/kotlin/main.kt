import javafx.concurrent.Task

fun main() {
//    val task3 = Task3()
//    var str: String
//
//    var array = emptyArray<Int>()
//
//    while (true) {
//        str = readLine()!!
//        when (str) {
//            "create" -> task3.createKeys()
//            "encrypt" -> {
//                array = task3.encrypt("Hello")
//                println(array.toList())
//            }
//            "decrypt" -> {
//                println(task3.decrypt(array))
//            }
//            "exit" -> return
//        }
//    }
    testTask3()

}

fun testTask3() {
    val task3 = Task3()

    task3.createKeys()
    val array = task3.encrypt("Max Sedov")
    println(array.toList())
    println(task3.decrypt(array))
}