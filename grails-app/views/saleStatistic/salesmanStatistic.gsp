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
            销售员销售统计
            %{--<small>汽车基本信息</small>--}%
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="saleStatistic" action="salesmanStatistic">财务管理</g:link></li>
            <li class="active">销售员销售统计</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <h2></h2>

        <div class="row">
            <div class="col-md-6">
                <div class="box box-success text-center">
                    <div class="box-header with-border">
                        <h3 class="box-title">不同销售员销售额统计</h3>

                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                    </div>

                    <div class="box-body">
                        <div class="chart">
                            <canvas id="barChart"></canvas>
                        </div>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->

            </div>

            <div class="col-md-6">
                <div class="box box-success text-center">
                    <div class="box-header with-border">
                        <h3 class="box-title">不同销售员销售数量统计</h3>

                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                    </div>

                    <div class="box-body">
                        <div class="chart">
                            <canvas id="barChart2"></canvas>
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
        $.post("/saleStatistic/getSalesmanData", null, function (bdata) {
            var ctx = $("#barChart").get(0).getContext("2d");
            var ctx2 = $("#barChart2").get(0).getContext("2d");
            var data = {
                labels: bdata.labelList,
                datasets: [
                    {
                        label: "销售额（万元）",
                        backgroundColor: "rgba(37,149,27,0.2)",
                        borderColor: "rgba(37,149,27,1)",
                        borderWidth: 1,
                        hoverBackgroundColor: "rgba(37,149,27,0.4)",
                        hoverBorderColor: "rgba(37,149,27,1)",
                        data: bdata.priceList,
                    }
                ]
            };
            var data2 = {
                labels: bdata.labelList,
                datasets: [
                    {
                        label: "销售数量",
                        backgroundColor: "rgba(61,103,149,0.2)",
                        borderColor: "rgba(61,103,149,1)",
                        borderWidth: 1,
                        hoverBackgroundColor: "rgba(61,103,149,0.4)",
                        hoverBorderColor: "rgba(61,103,149,1)",
                        data: bdata.numberList,
                    }
                ]
            };

            new Chart(ctx, {
                type: "bar",
                data: data,
                options: {}
            });
            new Chart(ctx2, {
                type: "bar",
                data: data2,
                options: {}
            });
        });


    });


</script>
