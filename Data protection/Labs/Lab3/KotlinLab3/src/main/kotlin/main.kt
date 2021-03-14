import javafx.concurrent.Task

fun main() {
    testTask3()
    println("\n\n")
    testTask5()
}

fun testTask3() {
    val task3 = Task3()

    task3.createKeys()
    val array = task3.encrypt("Max Sedov", true)
    println(array.toList())
    println(task3.decrypt(array, true))
}

fun testTask5() {
    val task5 = Task5()
    val hash = task5._hash("Max Sedov")
    println(hash)
    task5.createKeys()
    val array = task5.encrypt(hash, false)
    println(array.toList())
    println(task5.decrypt(array, false))
}