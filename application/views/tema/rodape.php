<div class="row-fluid">
    <div id="footer" class="span12">
        <a class="pecolor" href="https://www.instagram.com/moneysystem.br" target="_blank">
            <?= date('Y') ?> &copy; MoneySystem - Versão: <?= $this->config->item('app_version') ?>
        </a>
    </div>
</div>
<!--end-Footer-part-->
<script src="<?= base_url() ?>assets/js/bootstrap.min.js"></script>
<script src="<?= base_url() ?>assets/js/matrix.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var table = $('#tabela').DataTable({
            info: false,
            language: {
                url: "<?= base_url() ?>assets/js/dataTable_pt-br.json"
            },
            pageLength: 6
        });
        $('#customSearch').on('keyup', function() {
            table.search(this.value).draw();
        });
    });
</script>
<style>
    #tabela_filter, #tabela_length {
        display: none;
    }
</style>

</html>