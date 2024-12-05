package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	// 创建 gin 引擎
	r := gin.Default()

	// 定义路由
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "Hello Windsurf!",
		})
	})

	// 启动服务器
	r.Run(":8081")
}
