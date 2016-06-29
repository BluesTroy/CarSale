
<div class="content-wrapper">
    <section class="content-header">
        <h1>
            运营支出汇总
            %{--<small>平台账户往来</small>--}%
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> 主页</a></li>
            <li><g:link controller="finance" action="outcomeStatistic" >财务管理</g:link></li>
            <li class="active">运营支出汇总</li>
        </ol>
    </section>

    <section class="content">

        <div class="box">
            <div class="box-body">

                <form id="searchForm" method="get" action="/finance/loadOutcome.do" class="form-inline">

                    <div class="row">


                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="timeSpan">时间跨度</label>
                                <g:select id="timeSpan" name="timeSpan" class="form-control"
                                    from="${['年','月','日']}" keys="['1','2','3']" value="3"/>
                            </div>
                        </div>


                        <div class="col-md-1">
                            <button type="button" class="btn btn-default"
                                    onclick="javascript:searchPage();"><i class="fa fa-search"></i> 查询</button>
                        </div>
                    </div>
                </form>
            </div><!-- /.box-body -->
        </div><!-- /.box -->

        <div id="statistic_container" class="container">
            <g:render template="outcome_table"/>
        </div>

    </section>
</div>
<script>


    function searchPage() {
        loadPage();
    }
    function loadPage() {
        $.post("/finance/loadOutcome", $("#searchForm").serializeArray(), function (data) {
            $("#statistic_container").html(data);
        }, "html").done();
    }

</script>
