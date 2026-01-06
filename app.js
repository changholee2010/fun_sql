// express 서버모듈.
const express = require("express"); // 모듈 임포트.
const db = require("./db");

const app = express(); // 인스턴스 생성.

// URL 주소 - 실행함수 => 라우팅.
// "/"
app.get("/", (req, res) => {
  res.send("/ 이창호홈에 오신걸 환영합니다.");
});

// "/customer"
app.get("/customer", (req, res) => {
  res.send("/customer 경로가 호출됨.");
});

app.get("/product", (req, res) => {
  res.send("/product 경로가 호출됨.");
});

// "/student" -> 화면에 출력.
app.get("/student/:studno", async (req, res) => {
  const studno = req.params.studno;
  const qry = "select * from student where studno = " + studno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows); // 반환되는 결과값에서 rows 속성의 결과만.
});

// '/employee' -> 사원목록을 출력하는  라우팅.
app.get("/employee/:empno", async (req, res) => {
  const empno = req.params.empno;
  const connection = await db.getConnection();
  const result = await connection.execute(
    `select * from emp where empno = ${empno}`
  );
  res.send(result.rows); // 반환되는 결과값에서 rows 속성의 결과만.
});

// 서버실행.
app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000");
});
