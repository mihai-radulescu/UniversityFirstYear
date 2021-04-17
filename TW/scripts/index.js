// Import packages
const express = require("express/lib/express");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const cors = require("cors");
const uuidv1 = require('uuid/dist/v1');

const fs = require("fs");

// Aplicatia
const app = express();

// Middleware
app.use(morgan("tiny"));
app.use(bodyParser.json());
app.use(cors());

// Create
app.post("/games", (req, res) => {
  const gameList = readJSONFile();
  const newGame = req.body;
  newGame.id = uuidv1();
  const newGameList = [...gameList, newgame];
  writeJSONFile(newGameList);
  res.json(newGame);
});

// Read One
app.get("/games/:id", (req, res) => {
  const gameList = readJSONFile();
  const id = req.params.id;
  let idFound = false;
  let foundGame;

  gameList.forEach(game => {
    if (id === games.id) {
      idFound = true;
      foundGame = game
    }
  });

  if (idFound) {
    res.json(foundGame);
  } else {
    res.status(404).send(`Game ${id} was not found`);
  }
});

// Read All
app.get("/games", (req, res) => {
  const gameList = readJSONFile();
  res.json(gameList);
});

// Update
app.put("/games/:id", (req, res) => {
  const gameList = readJSONFile();
  const id = req.params.id;
  const newGame = req.body;
  newGame.id = id;
  idFound = false;

  const newGameList = gameList.map((game) => {
     if (game.id === id) {
       idFound = true;
       return newGame
     }
    return game
  })
  
  writeJSONFile(newGameList);

  if (idFound) {
    res.json(newGame);
  } else {
    res.status(404).send(`Game ${id} was not found`);
  }

});

// Delete
app.delete("/games/:id", (req, res) => {
  const gameList = readJSONFile();
  const id = req.params.id;
  const newGameList = gameList.filter((game) => game.id !== id)

  if (gameList.length !== newGameList.length) {
    res.status(200).send(`Game ${id} was removed`);
    writeJSONFile(newGameList);
  } else {
    res.status(404).send(`Game ${id} was not found`);
  }
});

// Functia de citire din fisierul db.json
function readJSONFile() {
  return JSON.parse(fs.readFileSync("db.json"))["games"];
}

// Functia de scriere in fisierul db.json
function writeJSONFile(content) {
  fs.writeFileSync(
    "db.json",
    JSON.stringify({ games: content }),
    "utf8",
    err => {
      if (err) {
        console.log(err);
      }
    }
  );
}

// Pornim server-ul
app.listen("3000", () =>
  console.log("Server started at: http://localhost:3000")
);