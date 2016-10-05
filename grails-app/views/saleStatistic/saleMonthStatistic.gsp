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
            汽车月销售额统计
            %{--<small>汽车基本信息</small>--}%
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="saleStatistic" action="saleMonthStatistic">财务管理</g:link></li>
            <li class="active">汽车月销售额统计</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        %{--<h2></h2>--}%

        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="box box-success text-center">
                    <div class="box-header with-border">
                        <h3 class="box-title">不同月份销售额统计</h3>

                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                    </div>

                    <div class="box-body">
                        <div class="chart">
                            <canvas id="barChart" ></canvas>
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
        $.post("/saleStatistic/getMonthData",null, function (bdata) {
            var ctx = $("#barChart").get(0).getContext("2d");
            var data = {
                labels: ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],
                datasets: [
                    {
                        label: "销售额（万元）",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(37,149,27,0.4)",
                        borderColor: "rgba(37,149,27,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(37,149,27,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(37,149,27,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: bdata.dataList,
                    }
                ]
            };
            new Chart(ctx, {
                type: "line",
                data: data,
                options: {
                }
            });
        });
    });


</script>
