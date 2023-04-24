package io.cloudtype.ktspring

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class KtspringApplication

fun main(args: Array<String>) {
	runApplication<KtspringApplication>(*args)
}
