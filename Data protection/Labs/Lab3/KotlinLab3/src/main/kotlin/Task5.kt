import java.math.BigInteger
import java.security.MessageDigest

class Task5: Task3() {
    private fun hashString(input: String, algorithm: String): String {
        return MessageDigest
            .getInstance(algorithm)
            .digest(input.toByteArray())
            .fold("", { str, it -> str + "%02x".format(it) })
    }

    private fun String.sha256(): String {
        return hashString(this, "SHA-256")
    }

    fun _hash(message: String): String {
        return message.sha256()
    }
}