package main

import (
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"net/http"
	"net/http/httptest"
)

var _ = Describe("Receive response from HTTP server ", func() {
	It("Should return status code 200", func() {
		router := setupRouter()

		responseRecorder := httptest.NewRecorder()
		request, err := http.NewRequest("GET", "/", nil)

		if err != nil {
			Fail(err.Error())
		}

		router.ServeHTTP(responseRecorder, request)

		Expect(responseRecorder.Code).To(Equal(http.StatusOK))
	})
})
