def task2():
    from functools import reduce

    def f(a, x):
        sbox = (
            (5, 15, 0, 12, 8, 4, 14, 2, 13, 11, 3, 6, 10, 1, 9, 7),
            (12, 13, 8, 14, 7, 5, 1, 6, 2, 3, 11, 0, 15, 9, 10, 4),
            (1, 10, 13, 9, 12, 0, 6, 3, 8, 15, 11, 2, 14, 4, 7, 5),
            (6, 9, 4, 2, 3, 13, 8, 14, 1, 11, 15, 7, 0, 10, 5, 12),
            (11, 0, 9, 10, 1, 2, 8, 12, 15, 3, 6, 4, 7, 5, 14, 13),
            (5, 15, 2, 1, 7, 14, 8, 6, 0, 10, 3, 9, 4, 13, 12, 11),
            (1, 0, 13, 4, 3, 2, 6, 11, 8, 5, 7, 14, 9, 10, 15, 12),
            (4, 5, 9, 11, 10, 1, 6, 13, 7, 2, 3, 0, 12, 14, 15, 8)
        )

        c = (a + x) & 0xFFFFFFFF
        seq = [(c >> (i * 4)) & 0xF for i in range(8)]
        seq = [sbox[i][seq[i]] for i in range(8)]

        out = reduce(lambda x, y: x | y, [seq[i] << (i * 4) for i in range(8)])
        return ((out >> 11) | (out << (32 - 11))) & 0xFFFFFFFF

    def split(block):
        number = int.from_bytes(block, 'little')
        return number & 0xFFFFFFFF, (number >> 32) & 0xFFFFFFFF

    def join(a, b):
        return ((b << 32) | a).to_bytes(8, 'little')

    def flipbytes(block):
        a, b = split(block)
        return join(b, a)

    def subkeys(key):
        K = [int.from_bytes(key[i * 4:i * 4 + 4], 'little') for i in range(8)]
        X = [K[i % 8] for i in range(24)] + [k for k in reversed(K)]

        return X

    def encround(block, subkey):
        a, b = split(block)
        a, b = b ^ f(a, subkey), a

        return join(a, b)

    def encrypt(block, key, rounds=32):
        for subkey in subkeys(key)[:rounds]:
            block = encround(block, subkey)
        return flipbytes(block)

    def decrypt(block, key, rounds=32):
        for subkey in reversed(subkeys(key)[:rounds]):
            block = encround(block, subkey)
        return flipbytes(block)

    plaintext = 'Sedov Maxim'.encode('utf-8')[:8]
    key = 'Результат разбивается на восемь'.encode('utf-8')[:32]

    print('2 rounds')
    print('plaintext:\t{}'.format(plaintext.hex()))
    ciphertext = encrypt(plaintext, key, 2)
    print('ciphertext:\t{}'.format(ciphertext.hex()))
    plaintext = decrypt(ciphertext, key, 2)
    print('plaintext:\t{}'.format(plaintext.hex()))

    print('32 rounds')
    print('plaintext:\t{}'.format(plaintext.hex()))
    ciphertext = encrypt(plaintext, key)
    print('ciphertext:\t{}'.format(ciphertext.hex()))
    plaintext = decrypt(ciphertext, key)
    print('plaintext:\t{}'.format(plaintext.hex()))


def task3():
    import math
    import random

    def isprime(num):
        if num <= 1:
            return False

        for i in range(2, math.ceil(math.sqrt(num))):
            if num % i == 0:
                return False

        return True

    def newkeys(p, q):
        n = p * q
        f = (p - 1) * (q - 1)

        E = [n for n in range(f) if isprime(n) and f % n != 0]
        e = random.choice(E)

        d = 1
        while (d * e) % f != 1:
            d += 1

        return (e, n), (d, n)

    def encrypt(message, pubkey):
        e, n = pubkey
        return list(pow(ord(c), e, n) for c in message)

    def decrypt(message, privkey):
        d, n = privkey
        return ''.join(chr(pow(c, d, n)) for c in message)

    random.seed(0)
    pubkey, privkey = newkeys(277, 521)
    plaintext = 'Sedov Maxim'
    print('plaintext:\t{}'.format(plaintext))
    ciphertext = encrypt(plaintext, pubkey)
    print('ciphertext:\t{}'.format(ciphertext))
    plaintext = decrypt(ciphertext, privkey)
    print('plaintext:\t{}'.format(plaintext))


def task4():
    def hash_(message):
        p = 277
        q = 521

        hashvalue = 0
        for i, c in enumerate(message):
            hashvalue = (hashvalue + pow(p * q, i, 1 << 128)
                         * ord(c) + 1) & ~(1 << 128)
        return hashvalue.to_bytes(16, 'little')

    plaintext = 'Sedov'
    print('plaintext:\t{}'.format(plaintext))
    hashvalue = hash_(plaintext)
    print('hash:\t{}'.format(hashvalue.hex()))


def task5():
    import math
    import random

    def isprime(num):
        if num <= 1:
            return False

        for i in range(2, math.ceil(math.sqrt(num))):
            if num % i == 0:
                return False

        return True

    def newkeys(p, q):
        n = p * q
        f = (p - 1) * (q - 1)

        E = [n for n in range(f) if isprime(n) and f % n != 0]
        e = random.choice(E)

        d = 1
        while (d * e) % f != 1:
            d += 1

        return (e, n), (d, n)

    def encrypt(message, pubkey):
        e, n = pubkey
        return list(pow(ord(c), e, n) for c in message)

    def decrypt(message, privkey):
        d, n = privkey
        return ''.join(chr(pow(c, d, n)) for c in message)

    def hash_(message):
        p = 277
        q = 521

        hashvalue = 0
        for i, c in enumerate(message):
            hashvalue = (hashvalue + pow(p * q, i, 1 << 128)
                         * ord(c) + 1) & ((1 << 128) - 1)
        return hashvalue.to_bytes(16, 'little')

    random.seed(0)
    pubkey, privkey = newkeys(277, 521)
    plaintext = 'Sedov Maxim'
    print('plaintext:\t{}'.format(plaintext))
    hashvalue = hash_(plaintext)
    print('hash:\t{}'.format(hashvalue.hex()))
    signature = encrypt(hashvalue.hex(), privkey)
    print('signature:\t{}'.format(signature))
    hashvalue = decrypt(signature, pubkey)
    print('hash:\t{}'.format(hashvalue))


if __name__ == "__main__":
    task2()
    print()
    task3()
    print()
    task4()
    print()
    task5()
    print()