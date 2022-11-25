<!DOCTYPE html>
<html>
<head>
    <title>Page Title</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>
</head>
<body style="background-color: #c0c0c0; margin: 20px; font-family: 'Montserrat'">


<div class="row">
    <div class="col-lg-12" style="text-align: center">
        <h1 style="font-weight: bold">Identify Minimum Connectors</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="text-align: left">
        <div id="table"></div>
    </div>
</div>
<div class="row" style="margin-top: 20px ">
    <div class="col-lg-12">
        <p><span style="color: darkred">*</span>Refer the above distance table and find the minimum connectors to all cities as well as minimum cumulative distance to connect each of them.</p>
    </div>
</div>
<div class="row" style="margin-top: 20px ">
    <div class="col-lg-6">
        <form id="answerInputSection" onsubmit="return false">
        </form>
    </div>
    <div class="col-lg-6">
        <h4  class="fw-b">Connect All Cities Starting From : <span id="startingPoint"></span></h4>
        <h5 class="fw-b mt-30" >Please follow below instructions :</h5>
        <p>1. You are only allowed to enter number value in minimum distance</p>
        <p>2. Please input the connected cities by separating them with "-" (Example: A-B-C-D-E...)</p>
        <p>3. Numbers are not allowed in the shortest path input text field</p>
    </div>
</div>


</body>
<script src="js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<script>


    let down = document.getElementById("answerInputSection");

    function generateAnswerInputSection() {
       $("#answerInputSection").empty();
            let div1 = document.createElement("div");
            div1.setAttribute("class", "form-group row");
            let label = document.createElement("label");
            label.setAttribute("class", "col-sm-3 col-form-label pt-0");
            label.textContent = "Minimum Connectors and Distance";
            div1.append(label);

            let div2 = document.createElement("div");
            div2.setAttribute("class", "col-sm-2");
            div1.append(div2);

            let inputShortestDistance = document.createElement("input");
            inputShortestDistance.setAttribute("type", "number");
            inputShortestDistance.setAttribute("class", "form-control");
            inputShortestDistance.setAttribute("required", "true");
            inputShortestDistance.setAttribute("placeholder", "Distance");
            inputShortestDistance.setAttribute("id", "minimumConnectorDistance");
            div2.append(inputShortestDistance);

            let div3 = document.createElement("div");
            div3.setAttribute("class", "col-sm-3");
            div1.append(div3);

            let inputShortestPath = document.createElement("input");
            inputShortestPath.setAttribute("type", "text");
            inputShortestPath.setAttribute("class", "form-control");
            inputShortestPath.setAttribute("placeholder", "Shortest Path");
            inputShortestPath.setAttribute("required", "true");
            inputShortestPath.setAttribute("onKeyPress", "removeTextBoxClass(this)");
            inputShortestPath.setAttribute("id", "minimumConnectorsPath");
            div3.append(inputShortestPath);

            let div4 = document.createElement("div");
            div4.setAttribute("class", "col-sm-4");
            div1.append(div4);

            let resultLabel = document.createElement("label");
            resultLabel.setAttribute("id", "minimumConnectorsResult");
            div4.append(resultLabel);

            down.appendChild(div1);


        let submitButton =  document.createElement("button");
        submitButton.setAttribute("class", "btn btn-secondary mr-2 mt-2");
        submitButton.setAttribute("type" ,"submit");
        submitButton.textContent = "Submit";
        down.append(submitButton);


        let restartGameButton =  document.createElement("button");
        restartGameButton.setAttribute("class", "btn btn-outline-dark mt-2");
        restartGameButton.setAttribute("onclick" ,"restartGameRound()");
        restartGameButton.textContent = "Restart";
        down.append(restartGameButton);
    }


    $("#answerInputSection").submit(function(e) {
        e.preventDefault();
        let minimumConnectorsPath = $("#minimumConnectorsPath").val();
        let minimumConnectorDistance = $("#minimumConnectorDistance").val();
        if(minimumConnectorsPath.match(/\d+/g) != null){
            $('#minimumConnectorsPath').addClass("border border-danger");
            return;
        }
        let answerObject = {questionId : "2" , minimumConnectorsUserAnswer : {}};
        answerObject.minimumConnectorsUserAnswer.totalDistance = minimumConnectorDistance;
        answerObject.minimumConnectorsUserAnswer.path = minimumConnectorsPath.replace(/[$@%^]/g, '').toUpperCase();
        answerObject.minimumConnectorsUserAnswer.startPoint = randomStartingPoint;

        $.ajax({
            url: baseUrl+'distanceGraph/userAnswers',
            type: 'POST',
            headers: {
                'userId': parseInt(getCookie("userId"))
            },
            contentType: "application/json",
            data: JSON.stringify(answerObject),
            success: function (results) {
                if(results.Data){
                    let labelID =  $("#minimumConnectorsResult");
                    $(labelID).html(results.Data.result);
                    if(results.Data.status === 1){
                        $(labelID).removeClass().addClass("text-success f-z15 mt-8");
                    }else if(results.Data.status === 2){
                        $(labelID).removeClass().addClass("text-info f-z15 mt-8");
                    }else if(results.Data.status === 0){
                        $(labelID).removeClass().addClass("text-danger f-z15 mt-8");
                    }
                }
            },
            error: function (xhr) {

            }
        });
    });

    function removeTextBoxClass(e){
        let labelID =  $("#minimumConnectorsResult");
        $(labelID).html('');
        $("#" + e.id).removeClass("border border-danger");
    }


</script>
<script>
    function restartGameRound(){
        headers = ["City A", "City B", "City C", "City D","City E","City F","City G","City H","City I"];
        rowHeaders = ["City A", "City B", "City C", "City D","City E","City F","City G","City H","City I","City J"];
        let gameUrl = baseUrl+'shortestPath/getTableData';
        getTableData(gameUrl);
    }
    $( document ).ready(function() {
        if(getCookie('userId') === 'null'){
            location.href='index.jsp';
        }
        restartGameRound();
        generateAnswerInputSection();
    });
</script>

</html>