var formAJAX = document.getElementById("form");
var addButton = document.getElementById("button-add");
var main = document.getElementById("main");
var submitButton = document.getElementById("submit-button");

//form data
var formGameName = document.getElementById("nume");
var formGameImg = document.getElementById("imagine");
var formGamePlatform = document.getElementById("platforma");
var formGameStatus = document.getElementById("status");
var formGameRating = document.getElementById("rating");


function showForm(){
    if(formAJAX.style.display == "flex"){
        formAJAX.style.display = "none";
        addButton.innerHTML = " <i class=\"fa fa-plus\" aria-hidden=\"true\"></i> ADD";
    } else {
        formAJAX.style.display = "flex";
        addButton.innerHTML = "<i class=\"fa fa-times\" aria-hidden=\"true\"></i>";
/*
        document.getElementById("submit-button").addEventListener('click', function() {
            postGames();
        });
*/
        resetForm();
    }

}



// fetch the dogs list
function getGames() {
    fetch('http://localhost:3000/games')
        .then(function (response) {
            // Trasform server response to get the dogs
            response.json().then(function (games) {
                appendGamesToDOM(games);

                local_name();
            });
        });
};


// post dogs
function postGames() {
    // creat post object
    const postObject = {
        name: formGameName.value,
        img: imgPath(formGameImg.value),
        status: formGameStatus.value,
        platform: formGamePlatform.value,
        rating: formGameRating.value
    }
    // post games
    fetch('http://localhost:3000/games', {
        method: 'post',
        headers: {
            "Content-type": "application/json"
        },
        body: JSON.stringify(postObject)
    }).then(function () {
        // Get the new dogs list
        getGames();
        // Reset Form
        resetForm();
    });
}


// delete game
function deleteGame(id) {
    // delete game
    fetch(`http://localhost:3000/games/${id}`, {
        method: 'DELETE',
    }).then(function () {
        // Get the new games list
        getGames();
    });
}


// update game
function updateGames(id, imgUrl) {
    // creat put object
    const putObject = {
        name: formGameName.value,
        img: imgPath(imgUrl),
        status: formGameStatus.value,
        platform: formGamePlatform.value,
        rating: formGameRating.value
    }
    // update dog
    fetch(`http://localhost:3000/games/${id}`, {
        method: 'PUT',
        headers: {
            "Content-type": "application/json"
        },
        body: JSON.stringify(putObject)
    }).then(function () {
        // Get the new games list
        getGames();

        // Reset Form
        resetForm();

        showForm();
    });
}


function editGames(game) {

    if(formAJAX.style.display == "none"){
        showForm();
    }

    formGameName.value = game.name;
    formGamePlatform.value = game.platform;
    formGameStatus.value = game.status;
    formGameRating.value = game.rating;

    var imgUrl = game.img;

    clearSubmitEvent();

    document.getElementById("submit-button").addEventListener('click', function() {
        
        if(formGameImg.value){
           imgUrl = formGameImg.value; 
        }
        
        updateGames(game.id, imgUrl);
    });

}



// appned games to dom
function appendGamesToDOM(games){

     // remove dog list if exist
     while (main.firstChild) {
        main.removeChild(main.firstChild);
    }

    for (let i = 0; i < games.length; i++){

        //create flip-card
        let flipCard = document.createElement("div");
        flipCard.className = "flip-card";
        main.appendChild(flipCard);

        //create flip-card-inner
        let flipCardInner = document.createElement("div");
        flipCardInner.className = "flip-card-inner";
        flipCard.appendChild(flipCardInner);

        //create flip-card-front
        let flipCardFront = document.createElement("div");
        flipCardFront.className = "flip-card-front";
        flipCardInner.appendChild(flipCardFront);

        //add img
        let img = document.createElement("img");
        img.src = games[i].img;
        img.className = "game-img";
        img.alt = "Game box-art";
        flipCardFront.appendChild(img);

        //add name
        let name = document.createElement("h2");
        name.innerHTML = games[i].name;
        flipCardFront.appendChild(name);

        //create flip-card-back
        let flipCardBack = document.createElement("div");
        flipCardBack.className = "flip-card-back";
        flipCardInner.appendChild(flipCardBack);

        //add platform
        let platform = document.createElement("h1");
        platform.innerHTML = games[i].platform;
        flipCardBack.appendChild(platform);

        //add status
        let status = document.createElement("h2");
        status.innerHTML = games[i].status;
        flipCardBack.appendChild(status);

        //add rating
        let rating = document.createElement("h3");
        rating.innerHTML = "Rating: " + games[i].rating;
        flipCardBack.appendChild(rating);

        //create edit button
        let editButton = document.createElement("button");
        editButton.className = "edit-button";

        editButton.innerHTML = " <i class=\"fa fa-pencil\" aria-hidden=\"true\"></i> Edit";
        flipCardBack.appendChild(editButton);

        editButton.addEventListener('click', function (){
            editGames(games[i]);
        });

        //create delete button
        let delButton = document.createElement("button");
        delButton.className = "delete-button";
        
        delButton.addEventListener('click', function () {
            deleteGame(games[i].id);
        });

        delButton.innerHTML = "<i class=\"fa fa-trash\" aria-hidden=\"true\"></i>  Delete";
        flipCardBack.appendChild(delButton);
    }
}

//form reset
function resetForm() {
    formGameName.value = '';
    formGameImg.value = '';
    formGamePlatform.selectedIndex = "def";
    formGameStatus.selectedIndex = "def";
    formGameRating.selectedIndex = "def";

    clearSubmitEvent();
    
    document.getElementById("submit-button").addEventListener('click', function() {
        postGames();
    });
}

// img file path correction
function imgPath(url) {
    url = url.replace("C:\\fakepath\\", "img/");
    return url;
}


function clearSubmitEvent(){
    let newSubmitButton = submitButton.cloneNode(true);
    submitButton.parentNode.replaceChild(newSubmitButton, submitButton);
    submitButton = document.getElementById("submit-button");
}


document.getElementById("submit-button").addEventListener('click', function() {
    postGames();
});

function local_name() {

    if(localStorage.getItem('user') === null) {
        var person = prompt("Please enter your name");
        if(person != null) {
            localStorage.setItem('user', person);
        }
    }
    
    person = localStorage.getItem('user');
    document.getElementById("username").innerHTML = person + ". Your game list is ready :)";
    
}

//local_name();
getGames();
