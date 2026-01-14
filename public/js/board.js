// fetch를 통해서 게시글 데이터 갖져오기.
fetch("boards")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    // 반복처리.
    result.forEach((elem) => {
      // tbody subject
      const insertHtml = `<tr>
            <td>${elem.BOARD_NO}</td>
            <td>${elem.TITLE}</td>
            <td>${elem.WRITER}</td>
            <td>${new Date(elem.WRITE_DATE).toLocaleString()}</td>
            <td><button onclick='deleteRow(${
              elem.BOARD_NO
            })' class='delete'>삭제</button></td>
          </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("afterbegin", insertHtml);
    }); // end of forEach.
  })
  .catch((err) => {
    console.log(err);
  });

// form에다가 submit 이벤트 등록.
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault();
  const board_no = document.querySelector("#postNo").value;
  const title = document.querySelector("#title").value;
  const content = document.querySelector("#content").value;
  const writer = document.querySelector("#writer").value;
  // 입력값 체크.
  if (!board_no || !title || !content || !writer) {
    alert("필수값 입력");
    return;
  }
  const data = { board_no, title, content, writer };

  // fetch호출.
  // POST요청.
  // 1. url 2. option object
  fetch("./add_board", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      return data.json();
    }) // fetch() 실행이 성공이면...
    .then((result) => {
      console.log(result);
      const insertHtml = `<tr>
            <td>${result.board_no}</td>
            <td>${result.title}</td>
            <td>${result.writer}</td>
            <td>${new Date().toLocaleString()}</td>
            <td><button onclick='deleteRow(${
              result.board_no
            })' class='delete'>삭제</button></td>
          </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("afterbegin", insertHtml);
    })
    .catch((err) => {
      console.log(err);
    }); // fetch() 실행이 에러이면...
});

// 글삭제.
function deleteRow(bno) {
  console.log(bno);
  fetch("/remove_board/" + bno) // localhost:3000/remove_board/35
    .then((response) => response.json())
    .then((data) => {
      console.log(data);
    })
    .catch((err) => console.log(err));
}
