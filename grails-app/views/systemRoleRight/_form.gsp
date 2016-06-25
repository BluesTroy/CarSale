<div class="container-fluid">
    <ul class="list-group">
        <g:each in="${systemMenus}">
            <li class="list-group-item">
            <div class="row">
                <div class="col-md-4">
                    <g:if test="${it.parentMenu != null}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</g:if>
                    <div class="checkbox">
                        <label>
                            <i class="fa fa-check-square-o" ></i> ${it.menuName}

                        </label>
                    </div>
                </div>

            </div>
        </g:each>

    </ul>
</div>

<script>

</script>
