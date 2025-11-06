import { useEffect, useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import styles from './tela.module.css';
import botao from '../../../css/botao.module.css';
import Voltar from '../../../components/Voltar';

export default function TelaAdocao() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [solicitacao, setSolicitacao] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [confirmAction, setConfirmAction] = useState({ mostrar: false, tipo: '', mensagem: '' });
  const [animachado, setAnimachado] = useState(null);

  // Carregar dados da solicitação
  const getSolicitacao = async () => {
    setLoading(true);
    setError('');
    
    try {
      const response = await endFetch.get(`/solicitacao-adocao/${id}`);
      console.log('Resposta da API:', response.data);
      
      setSolicitacao(response.data);
      if (response.data?.animachado) {
        setAnimachado(response.data.animachado);
      }
    } catch (err) {
      console.error('Erro ao carregar os dados:', err);
      setError('Erro ao carregar os dados da solicitação.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getSolicitacao();
  }, [id]);

  // Função para aceitar solicitação - CORRIGIDA
  const aceitarSolicitacao = async () => {
    if (!solicitacao?.id || !animachado?.id) {
      console.log('Dados inválidos:', solicitacao, animachado);
      setError('Dados inválidos para aprovação.');
      return;
    }

    try {
      const response = await endFetch.put(`/solicitacao-adocao/${solicitacao.id}/animal/${animachado.id}/aprovar`);
      
      if (response.status === 200) {
        console.log('Solicitação aprovada com sucesso!');
        navigate('/Adocao');
      }
    } catch (err) {
      console.error('Erro ao aprovar solicitação:', err);
      setError('Erro ao aprovar solicitação: ' + (err.response?.data || err.message));
    }
  };

  // Função para rejeitar solicitação - CORRIGIDA
  const rejeitarSolicitacao = async () => {
    try {
      // CORREÇÃO: Usando o endpoint correto e estrutura de dados esperada
      const response = await endFetch.put(`/solicitacao-adocao/${id}/status`, {
        status: 'REPROVADO' // O backend espera um objeto com campo "status"
      });
      
      console.log('Solicitação rejeitada com sucesso!', response);
      navigate('/Adocao');
    } catch (err) {
      console.error('Erro ao rejeitar solicitação:', err);
      setError('Erro ao rejeitar solicitação: ' + (err.response?.data || err.message));
    }
  };

  // Confirmação antes de aceitar/rejeitar
  const handleDecision = (tipo) => {
    setConfirmAction({
      mostrar: true,
      tipo,
      mensagem: `Tem certeza que deseja ${tipo === 'aceitar' ? 'aprovar' : 'rejeitar'} esta solicitação?`,
    });
  };

  const cancelarDecision = () => {
    setConfirmAction({ mostrar: false, tipo: '', mensagem: '' });
  };

  const confirmarDecision = () => {
    if (confirmAction.tipo === 'aceitar') {
      aceitarSolicitacao();
    } else {
      rejeitarSolicitacao();
    }
  };

  if (loading) return <div className={styles.carregando}>Carregando...</div>;
  if (error) return <div className={styles.erro}>{error}</div>;
  if (!solicitacao) return null;

  const prop = solicitacao.proprietario;
  const cepGoogle = prop?.cep ? prop.cep.replace(/\D/g, '') : null;

  return (
    <>
      <Header />
      <div className={styles.vizualizar}>
        <Voltar />
        <h1 className={styles.titulo}>Detalhes da Solicitação de Adoção</h1>

        <div className={styles.card}>
          {/* Informações do animachado */}
          <div className={styles.informacoes}>
            <h3>Dados do Animal</h3>
            <p><strong>ID:</strong> {animachado && animachado.id ? (
              <Link to={`/VisualizarAnimalAchado/${animachado.id}`}>{animachado.id}</Link>) : 'Não informado'}</p>
            <p><strong>Nome:</strong> {animachado?.nome}</p>
            <p><strong>Espécie:</strong> {animachado?.especie}</p>
            <p><strong>Idade:</strong> {animachado?.idade} anos</p>
          </div>

          {/* Informações do Solicitante */}
          <div className={styles.informacoes}>
            <h3>Dados do Solicitante</h3>
            <p><strong>Nome:</strong> {prop?.nome}</p>
            <p><strong>Email:</strong> {prop?.email}</p>
            <p><strong>Telefone:</strong> {prop?.telefone || 'Não informado'}</p>
            <p><strong>CPF:</strong> {prop?.cpf}</p>
            <p>
              <strong>Endereço:</strong> {prop?.logradouro}, {prop?.numeroend || ''} {prop?.complemento || ''}, {prop?.bairro}, {prop?.uf}
            </p>
            {cepGoogle && (
              <p>
                <a href={`https://www.google.com/maps/search/?api=1&query=${cepGoogle}`} target="_blank" rel="noopener noreferrer">
                  CEP:{cepGoogle}
                </a>
              </p>
            )}
          </div>

          {/* Botões de ação */}
          <div className={styles.botoes}>
            <button className={botao.bgreen} onClick={() => handleDecision('aceitar')}>Aceitar</button>
            <button className={botao.bred} onClick={() => handleDecision('rejeitar')}>Rejeitar</button>
          </div>

          {/* Caixa de Confirmação */}
          {confirmAction.mostrar && (
            <div className={styles.confirmacao}>
              <div>
                <p>{confirmAction.mensagem}</p>
                <button className={botao.bgreen} onClick={confirmarDecision}>Sim</button>
                <button className={botao.bred} onClick={cancelarDecision}>Cancelar</button>
              </div>
            </div>
          )}
        </div>
      </div>
    </>
  );
}