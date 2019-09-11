package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := setupRouter()

	r.Run(":3000")
}

func setupRouter() *gin.Engine {
	r := gin.Default()
	r.LoadHTMLGlob("templates/*")
	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", nil)
	})

	return r
}
