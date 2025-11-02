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
  const [confirmAction, setConfirmAction] = useState({ mostrar: false, tipo: '', mensagem: '' });

  const token = localStorage.getItem('token'); // assumindo que você tem token armazenado

  // 1️⃣ Puxar a solicitação
  const getSolicitacao = async () => {
    try {
      const res = await endFetch.get(`/solicitacaoadocao/${id}`);
      setSolicitacao(res.data);
      return res.data;
    } catch (err) {
      console.error(err);
      setError('Erro ao carregar solicitação');
      return null;
    }
  };

  // 2️⃣ Puxar o animal
  const getAnimal = async (animalId) => {
    try {
      const res = await endFetch.get(`/animachado/${animalId}`);
      setAnimal(res.data);
    } catch (err) {
      console.error(err);
      setError('Erro ao carregar dados do animal');
    }
  };

  // 3️⃣ Puxar o proprietário
  const getProprietario = async (propId) => {
    try {
      const res = await endFetch.get(`/usuario/${propId}`);
      setProprietario(res.data);
    } catch (err) {
      console.error(err);
      setError('Erro ao carregar dados do proprietário');
    }
  };

  const carregarTudo = async () => {
    setLoading(true);
    const sol = await getSolicitacao();
    if (sol) {
      if (sol.animachado_id) await getAnimal(sol.animachado_id);
      if (sol.proprietario_id) await getProprietario(sol.proprietario_id);
    }
    setLoading(false);
  };

  useEffect(() => {
    carregarTudo();
  }, [id]);

  if (loading) return <div className={styles.carregando}>Carregando...</div>;
  if (error) return <div className={styles.erro}>{error}</div>;

  const cepFormatado = proprietario?.cep?.replace(/\D/g, '');
  const googleMapsUrl = cepFormatado ? `https://www.google.com/maps/search/?api=1&query=${cepFormatado}` : '#';

  return (
    <>
      <Header />
      <div className={styles.visualizar}>
        <Link to={'/Adocao'}><p className={styles.voltar}>Voltar</p></Link>
        <h1 className={styles.titulo}>Detalhes da Solicitação de Adoção</h1>

        <div className={styles.card}>
          {/* Informações do Animal */}
          <div className={styles.informacoes}>
            <h3>Informações do Animal</h3>
            <p><strong>ID:</strong> {animal?.id || '-'}</p>
            <p><strong>Nome:</strong> {animal?.nome || '-'}</p>
            <p><strong>Espécie:</strong> {animal?.especie || '-'}</p>
            <p><strong>Idade:</strong> {animal?.idade || '-'}</p>
            <p><strong>Status:</strong> {animal?.status || '-'}</p>
            {animal?.imagem && <img src={animal.imagem} alt={animal.nome} className={styles.imagemAnimal} />}
          </div>

          {/* Informações do Solicitante */}
          <div className={styles.informacoes}>
            <h3>Informações do Solicitante</h3>
            <p><strong>Nome:</strong> {proprietario?.nome || '-'}</p>
            <p><strong>Email:</strong> {proprietario?.email || '-'}</p>
            <p><strong>Telefone:</strong> {proprietario?.telefone || '-'}</p>
            <p><strong>CPF:</strong> {proprietario?.cpf || '-'}</p>
            <p><strong>Endereço:</strong> {proprietario?.logradouro}, {proprietario?.numeroend || ''} {proprietario?.complemento || ''}, {proprietario?.bairro || ''}, {proprietario?.uf || ''}</p>
            {cepFormatado && (
              <p>
                <a href={googleMapsUrl} target="_blank" rel="noopener noreferrer">Ver no mapa</a>
              </p>
            )}
          </div>
        </div>
      </div>
    </>
  );
}
