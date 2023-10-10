import fs from "fs";
import path from "path";

function listFiles(folderPath) {
  const fileList = fs.readdirSync(folderPath);
  const myList = [];
  for (const file of fileList) {
    if (file.endsWith(".mp3")) {
      myList.push(folderPath + "/" + file);
    }
  }
  console.log("🚀 ~ listFiles ~ myList:", myList);
}
listFiles("audio/high");
listFiles("audio/medium");
listFiles("audio/low");
