package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

var table = make(map[string][]string)

func sortString(w string) string {
	s := strings.Split(w, "")
	sort.Strings(s)
	return strings.Join(s, "")
}

func addWord(word string) {
	key := sortString(strings.ToLower(word))
	if i, ok := table[key]; ok {
		table[key] = append(i, word)
	} else {
		table[key] = []string{word}
	}
}

func main() {
	file, _ := os.Open("wordlist.txt")
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		addWord(line)
	}

	cnt := 0
	for _, v := range table {
		if len(v) > 1 {
			fmt.Printf("%v\n", v)
			cnt++
		}
	}
	fmt.Println(cnt)
}
