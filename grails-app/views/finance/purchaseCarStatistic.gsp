<%--
  Created by IntelliJ IDEA.
  User: Troy
  Date: 2016/6/11
  Time: 12:47
--%>


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            进货汽车统计
            %{--<small>汽车基本信息</small>--}%
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="finance" action="purchaseCarStatistic">财务管理</g:link></li>
            <li class="active">进货汽车统计</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <h2></h2>

        <div class="row">
            <div class="col-md-12">
                <div class="box box-success text-center" style="width: 90%;height: 50%;margin: 0px auto;">
                    <div class="box-header with-border">
                        <h3 class="box-title">不同汽车品牌进货数量统计</h3>

                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                    </div>

                    <div class="box-body">
                        <div class="chart">
                            <canvas id="barChart" style="height:230px"></canvas>
                        </div>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->

            </div>
        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<!-- REQUIRED JS SCRIPTS -->

<!-- page script -->
<script>

    $(function () {
        $.post("/finance/getPurchaseData",null, function (bdata) {
            var ctx = $("#barChart").get(0).getContext("2d");
            var data = {
                labels: bdata.labelList,//["January", "February", "March", "April", "May", "June", "July"],
                datasets: [
                    {
                        label: "进货数量",
                        backgroundColor: "rgba(255,99,132,0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        borderWidth: 1,
                        hoverBackgroundColor: "rgba(255,99,132,0.4)",
                        hoverBorderColor: "rgba(255,99,132,1)",
                        data: bdata.valueList,//${valueList},
                    }
                ]
            };

            new Chart(ctx, {
                type: "bar",
                data: data,
                options: {
                    scales: {
                        xAxes: [{
                            stacked: true
                        }],
                        yAxes: [{
                            stacked: true
                        }]
                    }
                }
            });
        });




    });


</script>
