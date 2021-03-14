import java.math.BigInteger
import java.security.MessageDigest

class Task5: Task3() {
    private fun hashString(input: String, algorithm: String): String {
        return MessageDigest
            .getInstance(algorithm)
            .digest(input.toByteArray())
            .fold("", { str, it -> str + "%02x".format(it) })
    }

    fun String.sha256(): String {
        return hashString(this, "SHA-256")
    }

    fun _hash(message: String): String {
        val zero = 0
        var hashValue = zero.toBigInteger()

        message.forEachIndexed {
            i, element ->
            run {
                val bigP: BigInteger = p.toBigInteger()
                val one = 1
                hashValue = (hashValue + bigP
                    .multiply(q.toBigInteger())
                    .modPow(i.toBigInteger(), one.shl(128).toBigInteger())
                    .multiply(element.toInt().toBigInteger())
                    .add(one.toBigInteger()))
                    .and(one.shl(128).toBigInteger().subtract(one.toBigInteger()))
            }
        }
        return message.sha256()
    }
}