<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Notafiscal extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        
        // Carregar bibliotecas e helpers necessários
        $this->load->library('form_validation');
        $this->load->helper('url'); // Para usar base_url()
        $this->load->database();  // Certifique-se de que o banco de dados está carregado
    }

    public function adicionar()
    {
        // Inicialize a variável de erro
        $custom_error = false;

        // Defina as regras de validação
        $this->form_validation->set_rules('numero', 'Número da Nota Fiscal', 'required');
        $this->form_validation->set_rules('cliente', 'Cliente', 'required');
        $this->form_validation->set_rules('valor', 'Valor', 'required|decimal');

        // Verifica se o formulário foi submetido e se a validação passou
        if ($this->form_validation->run() === false) {
            // Se a validação falhar, exibe a view com os erros
            $data['custom_error'] = $custom_error; // Passa a variável de erro para a view
            $this->load->view('notafiscal/adicionar', $data);
        } else {
            // Se a validação passar, processa os dados
            $data = [
                'numero' => $this->input->post('numero'),
                'cliente' => $this->input->post('cliente'),
                'valor' => $this->input->post('valor'),
                'data_criacao' => date('Y-m-d H:i:s'),
            ];

            // Salva no banco de dados
            $inserted = $this->db->insert('notas_fiscais', $data);

            if ($inserted) {
                // Redireciona para uma página de sucesso ou mostra uma mensagem de sucesso
                $this->session->set_flashdata('success', 'Nota fiscal adicionada com sucesso!');
                redirect('notafiscal/sucesso');
            } else {
                // Caso haja um erro ao inserir, exibe uma mensagem de erro
                $custom_error = true;
                $data['custom_error'] = $custom_error;
                $data['error_message'] = 'Erro ao adicionar nota fiscal. Tente novamente!';
                $this->load->view('notafiscal/adicionar', $data);
            }
        }
    }

    public function sucesso()
    {
        // Exemplo de página de sucesso
        $this->load->view('notafiscal/sucesso');
    }
}