package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	r := setupRouter()

	r.Run(":3000")
}

func setupRouter() *gin.Engine {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.String(200, "Hello World!")
	})

	return r
}
