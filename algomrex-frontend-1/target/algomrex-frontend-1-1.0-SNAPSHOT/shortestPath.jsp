<!DOCTYPE html>
<html>
<head>
    <title>Page Title</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>
</head>
<body style="background-color: #E5E4E2; margin: 20px; font-family: 'Montserrat'; ">

</form>

<div class="row">
    <div class="col-lg-12" style="text-align: center">
        <h1 style="font-weight: bold">Identify Shortest Path</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="text-align: left">
        <div id="table"></div>
    </div>
</div>
<div class="row" style="margin-top: 20px ">
    <div class="col-lg-12">
        <p><span style="color: darkred">*</span>Refer the above distance table and find the shortest path between given two cities.</p>
    </div>
</div>
<div class="row" style="margin-top: 20px ">
    <div class="col-lg-6">
        <form id="answerInputSection" onsubmit="return false">
        </form>
    </div>
    <div class="col-lg-6">
        <h4  class="fw-b">Find The Shortest Paths And Distances For All Cities Starting From : <span id="startingPoint"></span></h4>
        <h5 class="fw-b mt-30" >Please follow below instructions :</h5>
        <p>1. You are only allowed to enter number value in minimum distance</p>
        <p>2. Please input the cities of path by separating them with "-" (Example: A-B-C-D-E...)</p>
        <p>3. Always remember to add starting point to beginning of the path</p>
        <p>4. Numbers are not allowed in the shortest path text input field</p>
        <p>5. Enter the stating city to root city itself and shortest distance as 0</p>
    </div>
</div>


</body>
<script src="js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<script>
    let down = document.getElementById("answerInputSection");

    function generateAnswerInputSection(rowHeaders) {
       $("#answerInputSection").empty();
        for (let i = 0; i < rowHeaders.length; i++) {
            let div1 = document.createElement("div");
            div1.setAttribute("class", "form-group row");
            let label = document.createElement("label");
            label.setAttribute("class", "col-sm-1 col-form-label" );
            label.textContent = rowHeaders[i];
            div1.append(label);

            let div2 = document.createElement("div");
            div2.setAttribute("class", "col-sm-2");
            div1.append(div2);

            let inputShortestDistance = document.createElement("input");
            inputShortestDistance.setAttribute("type", "number");
            inputShortestDistance.setAttribute("class", "form-control");
            inputShortestDistance.setAttribute("required", "true");
            inputShortestDistance.setAttribute("id", rowHeaders[i].replace(/\s/g, '_')+"_Dst");
            div2.append(inputShortestDistance);

            let div3 = document.createElement("div");
            div3.setAttribute("class", "col-sm-3");
            div1.append(div3);

            let inputShortestPath = document.createElement("input");
            inputShortestPath.setAttribute("type", "text");
            inputShortestPath.setAttribute("class", "form-control");
            inputShortestPath.setAttribute("destination-point", rowHeaders[i]);
            inputShortestPath.setAttribute("onKeyPress", "removeTextBoxClass()");
            inputShortestPath.setAttribute("id", rowHeaders[i].replace(/\s/g, '_')+"_Path");
            div3.append(inputShortestPath);

            let div4 = document.createElement("div");
            div4.setAttribute("class", "col-sm-4");
            div1.append(div4);

            let resultLabel = document.createElement("label");
            resultLabel.setAttribute("id", rowHeaders[i].replace(/\s/g, '_')+"_Result");
            div4.append(resultLabel);

            down.appendChild(div1);
        }

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
        let answerObject = {questionId: "1", answerList: []};
        for (let i = 0; i < rowHeaders.length; i++) {
            let shortestPathTextBoxID = $("#" + rowHeaders[i].replace(/\s/g, '_') + "_Path");
            let shortestDistanceTextBoxID = $("#" + rowHeaders[i].replace(/\s/g, '_') + "_Dst");
            let answerShortestPath = shortestPathTextBoxID.val().replace(/[$@%^]/g, '').toUpperCase();
            let answerShortestDistance = shortestDistanceTextBoxID.val();
            if (answerShortestPath.match(/\d+/g) != null) {
                shortestPathTextBoxID.addClass("border border-danger");
                return;
            } else {
                if (shortestPathTextBoxID.hasClass("border border-danger")) {
                    shortestPathTextBoxID.removeClass("border border-danger");
                }
                answerObject.answerList.push({
                    labelId: rowHeaders[i].replace(/\s/g, '_') + "_Result",
                    path: answerShortestPath,
                    distance: answerShortestDistance,
                    from: randomStartingPoint,
                    to: $(shortestPathTextBoxID).attr('destination-point')
                })
            }
        }
        $.ajax({
            url: baseUrl + 'distanceGraph/userAnswers',
            type: 'POST',
            headers: {
                'userId': parseInt(getCookie("userId"))
            },
            contentType: "application/json",
            data: JSON.stringify(answerObject),
            success: function (results) {
                if (results.Data) {
                    for (let data of results.Data) {
                        let labelID = "#" + data.labelId;
                        $(labelID).html(data.result);
                        if (data.status === 1) {
                            $(labelID).removeClass().addClass("text-success f-z15 mt-8");
                        } else if (data.status === 2) {
                            $(labelID).removeClass().addClass("text-info f-z15 mt-8");
                        } else if (data.status === 0) {
                            $(labelID).removeClass().addClass("text-danger f-z15 mt-8");
                        }
                    }
                }
            },
            error: function (xhr) {

            }
        });

    });


    function removeTextBoxClass(e){
            $("#" + e.id).removeClass("border border-danger");
    }

</script>
<script>
    function restartGameRound(){
        headers = ["City A", "City B", "City C", "City D","City E","City F","City G","City H","City I"];
        rowHeaders = ["City A", "City B", "City C", "City D","City E","City F","City G","City H","City I","City J"];
        let gameUrl = baseUrl+'shortestPath/getTableData';
        getTableData(gameUrl);
        generateAnswerInputSection(rowHeaders);
    }
    $( document ).ready(function() {
        if(getCookie('userId') === 'null'){
            location.href='index.jsp';
        }
        restartGameRound();
    });
</script>

</html>