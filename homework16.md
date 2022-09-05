# Задание 1.
nonstop@umbrella:~$ go version
go version go1.13.8 linux/amd64
# Задание 2. 
Ознакомился.
# Задание 3.

## Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf
```
package main
  import "fmt"
  func main() {
    var foot float64
      fmt.Print("Введите футы: ")
      fmt.Scanf("%f", &foot)           
      result := foot * 0.3048 
      fmt.Println("Метры:", result )
        }
```
```
nonstop@umbrella:~/go$ go run go1.go
Введите футы: 3
Метры: 0.9144000000000001
```

## Напишите программу, которая найдет наименьший элемент в любом заданном списке x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
```
        package main
        
        import "fmt"
        
        func main() {
            x := []int{48,2, 96,86,3,68,57,82,63,70,37,34,83,27,19,97,9,17,1}
            current := 0
            fmt.Println ("Список : ", x)
            for i, value := range x {
                if (i == 0) {
                   current = value 
                } else {
                    if (value < current){
                        current = value
                    }
                }
            }
            fmt.Println("Наименьший элемент : ", current)
        }    
```		
		
``		
nonstop@umbrella:~/go$ go run go2.go
Список :  [48 2 96 86 3 68 57 82 63 70 37 34 83 27 19 97 9 17 1]
Наименьший элемент :  1
```

## Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …). 
```
 package main
  import "fmt"
   func main() 
   {
    for i := 1; i <= 100; i++ 
	{
      if (i%3) == 0 {
        fmt.Print("[",i,"]")
      }
    }
  }
  
 ```
