<!DOCTYPE html>
<html>
<head>
    <title>Page Title</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>
</head>
<body style="background-color: #C2DFFF; margin: 20px; font-family: 'Montserrat'; ">


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://res.cloudinary.com/dxfq3iotg/raw/upload/v1569006288/BBBootstrap/choices.min.css?version=7.0.0">
<script src="https://res.cloudinary.com/dxfq3iotg/raw/upload/v1569006273/BBBootstrap/choices.min.js?version=7.0.0"></script>

<div class="row">
    <div class="col-lg-12" style="text-align: center">
        <h1 style="font-weight: bold">0/1 Knapsack Problem</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12" style="text-align: left">
        <div id="table"></div>
    </div>
</div>
<div class="row" style="margin-top: 20px ">
    <div class="col-lg-12">
        <p><span style="color: darkred">*</span>Refer the above distance table and selected the items which get maximum profit</p>
    </div>
</div>
<div class="row" style="margin-top: 20px ">
    <div class="col-lg-6">
        <div class="row d-flex" id="ssss">
            <div class="col-md-4">
                <select id="choices-multiple-remove-button" placeholder="Select the items" multiple>
                </select>
            </div>
            <div class="col-md-3">
                <p class="mt-8">Total Profit is : <span id="totalProfit"></span> </p>
            </div>
            <div class="col-md-3">
                <p id="knapsackResult" class="mt-8"></p>
            </div>
        </div>
        <form id="answerInputSection" onsubmit="return false">
        </form>
    </div>
    <div class="col-lg-6">
        <h4  class="fw-b">Find the maximum profit you can get</h4>
        <h5 class="fw-b mt-30" >Please follow below instructions :</h5>
        <p>1. You need to find a subset of these items which will give you maximum profit such that
            their cumulative weight is not more than 10 kg</p>
        <p>2. After selecting the items press submit button to check your answer</p>
    </div>
</div>


</body>
<script src="js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<script>


$('#choices-multiple-remove-button').change(function () {
    let selected = $("#choices-multiple-remove-button option:selected");
    let sum =0;
    selected.each(function () {
        const tsum = $(this).val();
        sum += Number(tsum);
    });
    $('#totalProfit').html(sum);
});

    let down = document.getElementById("answerInputSection");
    function generateAnswerInputSection() {
       $("#answerInputSection").empty();
        let submitButton =  document.createElement("button");
        submitButton.setAttribute("class", "btn btn-primary mr-2 mt-2");
        submitButton.setAttribute("onclick" ,"submitAnswer()");
        submitButton.textContent = "Submit";
        down.append(submitButton);


        let restartGameButton =  document.createElement("button");
        restartGameButton.setAttribute("class", "btn btn-outline-primary mt-2");
        restartGameButton.setAttribute("onclick" ,"restartGameRound()");
        restartGameButton.textContent = "Restart";
        down.append(restartGameButton);
    }


    function submitAnswer(){
        let answerObject = {questionId : "1" , knapsackUserAnswer :{totalProfit : parseInt($('#totalProfit').text())}};

        $.ajax({
            url: baseUrl+'knapsack/userAnswers',
            type: 'POST',
            headers: {
                'userId': parseInt(getCookie("userId"))
            },
            contentType: "application/json",
            data: JSON.stringify(answerObject),
            success: function (results) {
                if(results.Data){
                    $('#knapsackResult').html(results.Data.result);
                    if(results.Data.status === 1){
                        $('#knapsackResult').removeClass().addClass("text-success f-z15 mt-8");
                    }else {
                        $('#knapsackResult').removeClass().addClass("text-danger f-z15 mt-8");
                    }
                }
            },
            error: function (xhr) {

            }
        });
    }


    function removeTextBoxClass(e){
            $("#" + e.id).removeClass("border border-danger");
    }

</script>
<script>
    function restartGameRound(){
     location.reload();
    }
    $( document ).ready(function() {
        if(getCookie('userId') === 'null'){
            location.href='index.jsp';
        }
        headers = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"],
        rowHeaders = ["Weight", "Profit"];
        let gameUrl = baseUrl+'knapsack/getTableData';
        getTableData(gameUrl);
        generateAnswerInputSection();
    });
</script>

</html>