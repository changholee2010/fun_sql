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
      console.log(data);
      return data.text();
    }) // fetch() 실행이 성공이면...
    .then((result) => {
      if (result == "처리완료") {
        alert("성공");
      } else if (result == "처리중 에러") {
        alert("처리실패");
      }
    })
    .catch((err) => {
      console.log(err);
    }); // fetch() 실행이 에러이면...
});
