import Combine
import Foundation

Just(5).sink{
    print($0)
}

let provider = (1...10).publisher

provider.sink(receiveCompletion: {_ in
    print("데이터 끝")
}, receiveValue: {data in print(data)})

class CustomSubscriber: Subscriber {
    func receive(completion: Subscribers.Completion<Failure>) {
        print("모든 데이터의 발행이 완료되었습니다.")
    }
    
    func receive(subscription: Subscription) {
        print("데이터의 구독을 시작합니다.")
        //        subscription.request(.max(2)) /// request 개수 제한
        subscription.request(.unlimited)
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        print("데이터를 받았습니다.", input)
        return .none
    }
    
    typealias Input = String ///  성공타입
    typealias Failure = Never /// 실패타입
}


let publisher = ["A", "B", "C", "D", "E", "F", "G"].publisher

let subscriber = CustomSubscriber()

publisher.subscribe(subscriber)

let formatter = NumberFormatter()
formatter.numberStyle = .ordinal
(1...10).publisher.map{
    formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
}.sink{
    print($0)
}


let subject = PassthroughSubject<String, Error>()

subject.sink(receiveCompletion: {completion in
    ///에러가 발생해도 receiveCompletion이 호출 됨.
    switch completion{
    case .failure:
        print("Error!")
    case .finished:
        print("finished")
    }
}, receiveValue: {
    value in
    print(value)
})

/// 데이터를 외부에서 발행하기
subject.send("A")
subject.send("B")
/// 데이터 발행 종료
subject.send(completion: .finished)

let currentStatus = CurrentValueSubject<Bool, Error>(true)

currentStatus.sink(receiveCompletion: {completion in
    switch completion {
    case .failure:
        print("Error!")
    case .finished:
        print("End!")
    }
}, receiveValue: {value in print(value)})


print("init: \(currentStatus.value)")
currentStatus.send(false)

currentStatus.value = true


let externalProvider = PassthroughSubject<String, Never>()

let anyCancleable = externalProvider.sink{steam in
    print("delivered: \(steam)")
}

externalProvider.send("A")
externalProvider.send("B")
externalProvider.send("C")
anyCancleable.cancel()
externalProvider.send("D")

enum HTTPError: LocalizedError {
    case statusCode
    case post
}

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        fatalError("Error: \(error.localizedDescription)")
    }
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        fatalError("Error: invalid HTTP response code")
    }
    
    guard let data = data else {
        fatalError("Error: missing response data")
    }
    
    do {
        let decoder = JSONDecoder()
        let posts = try decoder.decode([Post].self, from: data)
        print(posts.map{$0.title})
    }
    catch {
        print("Error: \(error.localizedDescription)")
    }
}

//task.resume()


let arr: [Int] = [1, 2, 3, 4, 5]
print(arr.dropFirst())


/// Codable
struct User {
    enum CodingKeys: String, CodingKey { /// json key가 아닌 내가 원하는 이름으로 지정할 수 있게 해주는 프로토콜.
        case id
        case name
        case birth
        case phoneNum = "phone_num" /// json은 phone_num이지만 나는 phoneNum으로 쓰겠다. 키가 만약 같다면 위처럼 생략하면 됨.
    }
    let id: Int
    let name: String
    let birth: String
    let phoneNum: String
}

extension User: Codable { /// typealias Codable = Encodable & Decodable
    //    extension User: Decodable, Encodable {
    init(from decoder: Decoder) throws { /// decoder는 무조건 init이 있어야한다.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        birth = try container.decode(String.self, forKey: .birth)
        phoneNum = try container.decode(String.self, forKey: .phoneNum)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(birth, forKey: .birth)
        try container.encode(phoneNum, forKey: .phoneNum)
    }
}

func decode() {
    let jsonString = """
                       [
                           {
                               "id": 1,
                               "name": "shark1",
                               "birth": "1999-03-17",
                               "phone_num": "010-2222-3333"
                           },
                           {
                               "id": 2,
                               "name": "shark2",
                               "birth": "1999-03-19",
                               "phone_num": "010-2222-3334"
                           },
                           {
                               "id": 3,
                               "name": "shark3",
                               "birth": "1999-03-20",
                               "phone_num": "010-2222-3353"
                           }
                       ]
                     """
    let jsonData = jsonString.data(using: .utf8)
    do {
        guard let jsonData = jsonData else { return }
        print("jsonData: \(jsonData.debugDescription)")
        let dataModel = try JSONDecoder().decode([User].self, from: jsonData)
        print(dataModel)
    } catch let error {
        print("에러임. \(error)")
    }
    
    
}

decode()

func encode() {
    let userObject = User(id: 1, name: "shark1", birth: "2000-03-02", phoneNum: "010-3434-2222")
    
    do {
        let jsonData = try JSONEncoder().encode(userObject)
        let jsonString = String(data: jsonData, encoding: .utf8)
        guard let printJsonString = jsonString else {return}
        print(printJsonString)
    } catch let error {
        print("에러다. \(error)")
    }
}

encode()


/// enum
enum Animal: String {
    case dog
    case cat
    case rabbit
    case koala = "코알라"
    case etc
    func printAnimal(){
        switch animal {
        case .dog:
            print("개")
        case .cat:
            print("고양이")
        case .rabbit:
            print("토끼")
        case .koala:
            print(Animal.koala.rawValue)
        case .etc:
            print("그 외")
            
        }
    }
}

let animal = Animal.koala
Animal.etc.printAnimal()

enum Animal2 {
    case dog
    case cat
    case rabbit
    case etc(String)
}

let animal2 = Animal2.etc("호랑이")
switch animal2 {

    case .dog:

        print("개 입니다.")

    case .cat:

        print("고양이 입니다.")

    case .rabbit:

        print("토끼 입니다.")

    case .etc(let etcs):

        print("\(etcs) 입니다.")
}

// MARK: - Struct
struct Student {
    let name: String?
    let birth: String?
    let grade: String?
    let gender: String?
}

struct Teacher {
    let name: String?
    let job: String?
}

// MARK: - Enum
enum School {
    case students(Student)
    case teachers(Teacher)
}

// MARK: - Public
func printStudent(_ student: Student) {
    guard let name = student.name,
        let birth = student.birth,
        let grade = student.grade,
        let gender = student.gender
        else {return}
    
    print("이름: \(name), 생년월일: \(birth), 학년: \(grade), 성별: \(gender)")
}

func printTeacher(_ teacher: Teacher) {
    guard let name = teacher.name,
        let job = teacher.job
        else {return}
    
    print("선생님 성함: \(name), 선생님 과목: \(job)")
}

// MARK: - Property
// student 초기값 설정
let jellStudent = Student(name: "Jell", birth: "1995.02.27", grade: "3", gender: "남")
// teacher 초기값 설정
let mystralTeacher = Teacher(name: "Mystral", job: "개발")
var student: School? {
    didSet {
        // student 연관값 수신
        guard case .students(let student)? = student
            else {return}
        printStudent(student)
    }
}

var teacher: School? {
    didSet {
        // teacher 연관값 수신
        guard case .teachers(let teacher)? = teacher
            else {return}
        printTeacher(teacher)
    }
}

student = School.students(jellStudent)
teacher = School.teachers(mystralTeacher)

//enum Result {
//    case success(T)
//    case failure
//}
//
//protocol ColorProtocol {
//    func getColor() -> Result<String>
//}
//
//extension ColorProtocol {
//    func printColor() {
//        switch getColor() {
//        case .success(let color):
//            print("색: \(color)")
//        case .failure:
//            print("색이 아님 ㅋㅋㅋㅋ")
//        }
//    }
//}
//
//class JellColor: ColorProtocol {
//    func getColor() -> Result<String> {
//        return .success("빨강")
//    }
//}
//
//class NoColor: ColorProtocol {
//    func getColor() -> Result<String> {
//        return .failure
//    }
//}
//
//JellColor().printColor()
//NoColor().printColor()

// MARK: - Struct

/**
 Struct를 쓰는 case.
 ------------------------------------------------------------------------
 관계된 간단한 값을 캡슐화 하기 위한 것일 때
 인스터스가 참조되기 보다 복사되기를 바랄 때
 프로퍼티가 참조되기 보다 복사되기를 바랄 때
 프로퍼티나 메소드 등을 상속할 필요가 없을 때
 ------------------------------------------------------------------------------------------------------------
 */
struct UserData {
    var name: String
    var age: Int
    mutating func updateUser(_ name: String, _ age: Int) { /// struct는 value type이기 때문에 method안에서 property변경이 불가능. 따라서 mutatng을 붙여줘야 변경이 가능함.
        self.name = name
        self.age = age
        
        print("name: \(name), age: \(age)")
    }
}

var jellUserData = UserData(name: "Jell", age: 20)
print("name: \(jellUserData.name), age: \(jellUserData.age)")
var mystralUserData = jellUserData
mystralUserData.name = "Mystral" /// <- 이 때 복사가 일어남. 이유는 값 복사이면서 copy-on-write이기 때문.
mystralUserData.age = 32

jellUserData.updateUser("우왕", 33)

// MARK: - Class
class Phone {
    var name: String
    var color: String
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func updatePhone(name: String, color: String) {
        self.name = name
        self.color = color
        
        print("Phone: \(name), color: \(color)")
    }
}

let iPhone8 = Phone(name: "iPhone8", color: "red")
print("Phone: \(iPhone8.name), color: \(iPhone8.color)")

iPhone8.updatePhone(name: "iPphoe8Plus", color: "gold")
