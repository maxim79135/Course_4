import java.math.BigInteger
import kotlin.math.sqrt

open class Task3 {
    private val p = 431
    private val q = 307
    private var n = 0
    private var e = 0
    private var d = 0

    private fun isPrime(num: Int): Boolean {
        if (num <= 1) return false

        for (i in 2..sqrt(num.toDouble()).toInt()) {
            if (num % i == 0) return false
        }
        return true
    }

    fun createKeys() {
        n = p * q
        val f = (p - 1) * (q - 1)

        var eArray = emptyArray<Int>()
        for (i in 1..f) {
            if (isPrime(i) and (f % i != 0)) eArray += i
        }

        e = eArray.random()
        d = 1
        var bigD: BigInteger = d.toBigInteger()
        while (bigD.multiply(e.toBigInteger()).mod(f.toBigInteger()).toInt() != 1) {
            d += 1
            bigD = d.toBigInteger()
        }

    }

fun encrypt(message: String): Array<Int> {
    var ret = emptyArray<Int>()
    for (c in message) {
        val tmp: BigInteger = c.toInt().toBigInteger()
        ret += tmp.modPow(e.toBigInteger(), n.toBigInteger()).toInt()
    }
    return ret
}

fun decrypt(message: Array<Int>): String {
    var ret = ""
    for (c in message) {
        val tmp: BigInteger = c.toBigInteger()
        ret += tmp.modPow(d.toBigInteger(), n.toBigInteger()).toInt().toChar()
    }
    return ret
}
}