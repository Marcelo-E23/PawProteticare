import { useEffect, useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import styles from './visualizar.module.css';
import botao from '../../../css/botao.module.css';

export default function VisualizarAdocao() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [solicitacao, setSolicitacao] = useState(null);
  const [animal, setAnimal] = useState(null);
  const [proprietario, setProprietario] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // 1️⃣ Puxar a solicitação com todos os dados relacionados
  const getSolicitacaoCompleta = async () => {
    try {
      setLoading(true);
      setError('');
      
      const response = await endFetch.get(`/solicitacao-adocao/${id}`);
      console.log('Dados da solicitação:', response.data); // DEBUG
      
      setSolicitacao(response.data);
      
      // Verifica se os dados relacionados já vêm na resposta
      if (response.data.animachado) {
        setAnimal(response.data.animachado);
      } else if (response.data.animachado_id) {
        // Se não vier completo, busca o animal separadamente
        await getAnimal(response.data.animachado_id);
      } else if (response.data.animal) {
        setAnimal(response.data.animal);
      } else if (response.data.animal_id) {
        await getAnimal(response.data.animal_id);
      }
      
      if (response.data.proprietario) {
        setProprietario(response.data.proprietario);
      } else if (response.data.proprietario_id) {
        await getProprietario(response.data.proprietario_id);
      } else if (response.data.solicitante) {
        setProprietario(response.data.solicitante);
      } else if (response.data.solicitante_id) {
        await getProprietario(response.data.solicitante_id);
      }
      
    } catch (err) {
      console.error('Erro ao carregar solicitação:', err);
      setError('Erro ao carregar dados da solicitação: ' + (err.response?.data?.message || err.message));
    } finally {
      setLoading(false);
    }
  };

  // 2️⃣ Puxar o animal (fallback)
  const getAnimal = async (animalId) => {
    try {
      // Tenta diferentes endpoints possíveis
      let res;
      try {
        res = await endFetch.get(`/animachado/${animalId}`);
      } catch (err) {
        console.log('Tentando endpoint alternativo para animal...');
        res = await endFetch.get(`/animal/${animalId}`);
      }
      setAnimal(res.data);
    } catch (err) {
      console.error('Erro ao carregar animal:', err);
      // Não seta erro global para não quebrar a tela toda
    }
  };

  // 3️⃣ Puxar o proprietário (fallback)
  const getProprietario = async (propId) => {
    try {
      // Tenta diferentes endpoints possíveis
      let res;
      try {
        res = await endFetch.get(`/usuario/${propId}`);
      } catch (err) {
        console.log('Tentando endpoint alternativo para proprietário...');
        res = await endFetch.get(`/proprietario/${propId}`);
      }
      setProprietario(res.data);
    } catch (err) {
      console.error('Erro ao carregar proprietário:', err);
      // Não seta erro global para não quebrar a tela toda
    }
  };

  useEffect(() => {
    getSolicitacaoCompleta();
  }, [id]);

  // Função para debug - mostra estrutura dos dados
  useEffect(() => {
    if (solicitacao) {
      console.log('Estrutura completa da solicitação:', solicitacao);
      console.log('Chaves da solicitação:', Object.keys(solicitacao));
    }
  }, [solicitacao]);

  if (loading) return <div className={styles.carregando}>Carregando...</div>;
  if (error) return <div className={styles.erro}>{error}</div>;
  if (!solicitacao) return <div className={styles.erro}>Solicitação não encontrada</div>;

  // Formatação segura dos dados
  const cepFormatado = proprietario?.cep?.replace(/\D/g, '') || 
                      solicitacao?.proprietario?.cep?.replace(/\D/g, '');
  
  const googleMapsUrl = cepFormatado ? 
    `https://www.google.com/maps/search/?api=1&query=${cepFormatado}` : '#';

  // Dados do animal (prioridade: animal separado > animal na solicitação)
  const dadosAnimal = animal || solicitacao.animachado || solicitacao.animal;
  
  // Dados do proprietário (prioridade: proprietário separado > proprietário na solicitação)
  const dadosProprietario = proprietario || solicitacao.proprietario || solicitacao.solicitante;

  return (
    <>
      <Header />
      <div className={styles.visualizar}>
        <Voltar />

        <div className={styles.card}>
          {/* Informações do Animal */}
          <div className={styles.informacoes}>
            <h3>Informações do Animal</h3>
            <p><strong>ID:</strong> {dadosAnimal?.id || 'Não informado'}</p>
            <p><strong>Nome:</strong> {dadosAnimal?.nome || 'Não informado'}</p>
            <p><strong>Espécie:</strong> {dadosAnimal?.especie || 'Não informado'}</p>
            <p><strong>Idade:</strong> {dadosAnimal?.idade || 'Não informado'}</p>
            <p><strong>Status:</strong> {dadosAnimal?.status || 'Não informado'}</p>
            <p><strong>Prótese:</strong> {dadosAnimal?.protese || 'Não informado'}</p>
            {dadosAnimal?.imagem && (
              <div className={styles.imagemContainer}>
                <img src={dadosAnimal.imagem} alt={dadosAnimal.nome} className={styles.imagemAnimal} />
              </div>
            )}
          </div>

          {/* Informações do Solicitante */}
          <div className={styles.informacoes}>
            <h3>Informações do Solicitante</h3>
            <p><strong>Nome:</strong> {dadosProprietario?.nome || 'Não informado'}</p>
            <p><strong>Email:</strong> {dadosProprietario?.email || 'Não informado'}</p>
            <p><strong>Telefone:</strong> {dadosProprietario?.telefone || 'Não informado'}</p>
            <p><strong>CPF:</strong> {dadosProprietario?.cpf || 'Não informado'}</p>
            <p>
              <strong>Endereço:</strong> {
                (dadosProprietario?.logradouro || dadosProprietario?.endereco) ? 
                `${dadosProprietario.logradouro || dadosProprietario.endereco}, ${dadosProprietario.numeroend || dadosProprietario.numero || ''} ${dadosProprietario.complemento || ''}, ${dadosProprietario.bairro || ''}, ${dadosProprietario.uf || ''}` :
                'Não informado'
              }
            </p>
            {cepFormatado && (
              <p>
                <a href={googleMapsUrl} target="_blank" rel="noopener noreferrer" className={styles.linkMapa}>
                  📍 Ver localização no Google Maps (CEP: {cepFormatado})
                </a>
              </p>
            )}
          </div>
        </div>
      </div>
    </>
  );
}