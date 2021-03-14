import com.sun.org.apache.xpath.internal.operations.Bool
import java.math.BigInteger
import kotlin.math.sqrt

open class Task3 {
    protected val p = 431
    protected val q = 307
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

    fun encrypt(message: String, isPubKey: Boolean): Array<Int> {
        var ret = emptyArray<Int>()
        for (c in message) {
            val tmp: BigInteger = c.toInt().toBigInteger()
            ret += tmp.modPow((if (isPubKey) e else d).toBigInteger(), n.toBigInteger()).toInt()
        }
        return ret
    }

    fun decrypt(message: Array<Int>, isPrivKey: Boolean): String {
        var ret = ""
        for (c in message) {
            val tmp: BigInteger = c.toBigInteger()
            ret += tmp.modPow(((if (isPrivKey) d else e)).toBigInteger(), n.toBigInteger()).toInt().toChar()
        }
        return ret
    }
}