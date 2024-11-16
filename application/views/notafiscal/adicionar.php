<?php $this->load->helper('url'); ?>
<!-- Carregando os arquivos CSS e JS -->
<link rel="stylesheet" href="<?php echo base_url(); ?>assets/js/jquery-ui/css/smoothness/jquery-ui-1.9.2.custom.css" />
<script type="text/javascript" src="<?php echo base_url() ?>assets/js/jquery-ui/js/jquery-ui-1.9.2.custom.js"></script>
<script type="text/javascript" src="<?php echo base_url() ?>assets/js/jquery.validate.js"></script>
<link rel="stylesheet" href="<?php echo base_url() ?>assets/trumbowyg/ui/trumbowyg.css">
<script type="text/javascript" src="<?php echo base_url() ?>assets/trumbowyg/trumbowyg.js"></script>
<script type="text/javascript" src="<?php echo base_url() ?>assets/trumbowyg/langs/pt_br.js"></script>

<link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/custom.css" />

<div class="row-fluid" style="margin-top:0">
    <div class="span12">
        <div class="widget-box">
            <div class="widget-title" style="margin: -20px 0 0">
                <span class="icon">
                    <i class="fas fa-file-invoice"></i>
                </span>
                <h5>Criar Nota Fiscal</h5>
            </div>
            <div class="widget-content nopadding tab-content">
                <div class="span12" id="divProdutosServicos" style=" margin-left: 0">
                    <ul class="nav nav-tabs">
                        <li class="active" id="tabDetalhes"><a href="#tab1" data-toggle="tab">Detalhes da Nota Fiscal</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab1">
                            <div class="span12" id="divCadastrarNotaFiscal">
                                <?php if ($custom_error) { ?>
                                    <div class="span12 alert alert-danger" id="divInfo" style="padding: 1%;">Dados incompletos, verifique os campos com asterisco ou se selecionou corretamente cliente e responsável.</div>
                                <?php } ?>
                                <form action="<?php echo current_url(); ?>" method="post" id="formNotasFiscais">
                                    <div class="span12" style="padding: 1%">

                                        <!-- Data de Emissão -->
                                        <div class="span2">
                                            <label for="dataEmissao">Data da Emissão<span class="required">*</span></label>
                                            <input id="dataEmissao" class="span12 datepicker" type="text" name="dataEmissao" value="<?php echo date('d/m/Y'); ?>" />
                                        </div>

                                        <!-- Cliente -->
                                        <div class="span3">
                                            <label for="cliente">Cliente<span class="required">*</span></label>
                                            <input id="cliente" class="span12" type="text" name="cliente" value="" />
                                            <input id="clientes_id" class="span12" type="hidden" name="clientes_id" value="" />
                                            <div class="addclient">
                                                <?php if ($this->permission->checkPermission($this->session->userdata('permissao'), 'aCliente')) { ?>
                                                    <a href="<?php echo base_url(); ?>index.php/clientes/adicionar" class="btn btn-success"><i class="fas fa-plus"></i> Adicionar Cliente</a>
                                                <?php } ?>
                                            </div>
                                        </div>

                                        <!-- Descrição da Nota -->
                                        <div class="span3">
                                            <label for="descricao">Descrição da Nota<span class="required">*</span></label>
                                            <textarea id="descricao" class="span12" name="descricao"></textarea>
                                        </div>

                                        <!-- Valor Total -->
                                        <div class="span2">
                                            <label for="valor">Valor Total (R$)<span class="required">*</span></label>
                                            <input id="valor" class="span12 money" type="text" name="valor" value="" />
                                        </div>

                                        <!-- Desconto -->
                                        <div class="span2">
                                            <label for="desconto">Desconto (R$)</label>
                                            <input id="desconto" class="span12 money" type="text" name="desconto" value="0" />
                                        </div>

                                        <!-- Valor Final -->
                                        <div class="span2">
                                            <label for="valor_final">Valor Final (R$)<span class="required">*</span></label>
                                            <input id="valor_final" class="span12 money" type="text" name="valor_final" value="" readonly />
                                        </div>

                                        <!-- Observações -->
                                        <div class="span6" style="padding: 1%; margin-left: 0">
                                            <label for="observacoes">
                                                <h4>Observações</h4>
                                            </label>
                                            <textarea class="editor" name="observacoes" id="observacoes" cols="30" rows="5"></textarea>
                                        </div>

                                        <!-- Botões -->
                                        <div class="span12" style="padding: 1%; margin-left: 0">
                                            <div class="span6 offset3" style="display:flex;justify-content: center">
                                                <button class="button btn btn-success" id="btnEmitir"><span class="button__icon"><i class='bx bx-chevrons-right'></i></span><span class="button__text2">Emitir Nota</span></button>
                                                <a href="<?php echo base_url() ?>index.php/notasfiscais" class="button btn btn-mini btn-warning"><span class="button__icon"><i class="bx bx-undo"></i></span> <span class="button__text2">Voltar</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script JS -->
<script type="text/javascript">
    $(document).ready(function() {
        $('.addclient').hide();

        $("#cliente").autocomplete({
            source: "<?php echo base_url(); ?>index.php/notasfiscais/autoCompleteCliente",
            minLength: 1,
            select: function(event, ui) {
                $("#clientes_id").val(ui.item.id);
                $('.addclient').hide();
            }
        });

        // Validação do formulário
        $("#formNotasFiscais").validate({
            rules: {
                cliente: { required: true },
                descricao: { required: true },
                dataEmissao: { required: true },
                valor: { required: true }
            },
            messages: {
                cliente: { required: 'Campo Requerido.' },
                descricao: { required: 'Campo Requerido.' },
                dataEmissao: { required: 'Campo Requerido.' },
                valor: { required: 'Campo Requerido.' }
            },
            errorClass: "help-inline",
            errorElement: "span",
            highlight: function(element, errorClass) {
                $(element).parents('.control-group').addClass('error');
            },
            unhighlight: function(element, errorClass) {
                $(element).parents('.control-group').removeClass('error');
            }
        });

        // Configuração do datepicker
        $(".datepicker").datepicker({ dateFormat: 'dd/mm/yy' });

        // Atualizando o valor final
        $('#valor, #desconto').on('input', function() {
            const valor = parseFloat($('#valor').val()) || 0;
            const desconto = parseFloat($('#desconto').val()) || 0;
            $('#valor_final').val((valor - desconto).toFixed(2));
        });

        // Inicialização do editor Trumbowyg
        $('.editor').trumbowyg({
            lang: 'pt_br',
            semantic: { 'strikethrough': 's', }
        });
    });
</script>