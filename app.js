// express 서버모듈.
const express = require("express"); // 모듈 임포트.
const db = require("./db");

const app = express(); // 인스턴스 생성.

app.use(express.static("public"));
app.use(express.json());

// URL 주소 - 실행함수 => 라우팅.
// "/"
app.get("/", (req, res) => {
  res.send("/ 이창호홈에 오신걸 환영합니다.");
});

// 댓글 전체 목록을 반환.
app.get("/boards", async (req, res) => {
  const qry = "select * from board order by 1";
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    console.log("성공");
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    res.send("실패");
  }
});

// 요청방식 GET vs. POST
// get : 단순조회.
// post : 많은 양의 전달.
app.post("/add_board", async (req, res) => {
  const { board_no, title, content, writer } = req.body;
  const qry = `insert into board (board_no, title, content, writer)
               values(:board_no, :title, :content, :writer)`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      board_no,
      title,
      content,
      writer,
    ]);
    console.log(result); // { lastRowid: 'AAAS2aAAHAAAAN1AAF', rowsAffected: 1 }
    connection.commit();
    res.send("처리완료"); // 서버 -> 클라이언트 응답 결과.
  } catch (err) {
    console.log(err);
    res.send("처리중 에러");
  }
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
