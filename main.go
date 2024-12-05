package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {

	// 创建 gin 引擎
	r := gin.Default()

	// 创建一个静态文件服务，用于提供音频文件
	r.Static("/static", "./static")

	// 主页面，返回一个简单的 HTML 页面，其中包含音频播放器
	r.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", gin.H{
			"title": "Welcome to Music Player",
		})
	})

	// 设置 HTML 模板目录
	r.LoadHTMLGlob("templates/*")

	log.Println("服务器启动在 :8081 端口...")
	// 启动服务器
	r.Run(":8081")
}
