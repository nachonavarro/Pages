<p align="center">
  <img src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/banner.png" height=58 width=182/>
</p>
<p align="center">
    <strong><a href="#getting-started">Getting Started</a></strong> |
    <strong><a href="#installation">Installation</a></strong>
</p>

<br/>

<p align="middle">
  <img src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/art-demo.gif" data-canonical-src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/art-demo.gif" width="200"/>
        
  <img src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/onboarding-demo.gif" data-canonical-src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/onboarding-demo.gif" width="200"/>
  
  <img src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/shapes-demo.gif" data-canonical-src="https://github.com/nachonavarro/PagesDemo/blob/master/Screenshots/shapes-demo.gif" width="200"/>
</p>

## Getting Started

### Basic usage

Using Pages is as easy as:

```Swift
  Pages {
      Text("A page here...")             // First page
      Text("...and a page there")        // Second page
      Circle()                           // Third page
          .frame(width: 50, height: 50)
      HStack {                           // Fourth page
          Text("Two texts side by side")
          Text("On the fourth page")
      }
  }
```

One can also use Pages for dynamic content:

```Swift
  struct Car {
      var model: String
  }
  
  let cars = [Car(model: "Ford"), Car(model: "Ferrari")]
  
  ModelPages(cars) { index, car in
      Text("The \(index) car is a \(car.model)")
          .padding(50)
          .foregroundColor(.white)
          .background(Color.blue)
          .cornerRadius(10)
  }
```

