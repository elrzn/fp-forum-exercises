package main

import (
	"bufio"
	"fmt"
	"log"
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
	i, ok := table[key]
	if ok {
		table[key] = append(i, word)
	} else {
		table[key] = []string{word}
	}
}

func main() {
	file, err := os.Open("wordlist.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	cnt := 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		addWord(line)
	}

	for _, v := range table {
		if len(v) > 1 {
			for _, s := range v {
				fmt.Printf("%s ", s)
			}
			fmt.Println("")
			cnt++
		}
	}

	fmt.Println(cnt)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
