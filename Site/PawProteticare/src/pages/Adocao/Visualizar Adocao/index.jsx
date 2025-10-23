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
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [confirmAction, setConfirmAction] = useState({ mostrar: false, tipo: '', mensagem: '' });

    const getSolicitacao = async () => {
        try {
            const token = localStorage.getItem('access_token');
            const response = await endFetch.get(`/solicitacaoadocao/${id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
            setSolicitacao(response.data);
        } catch (err) {
            console.error(err);
            setError('Erro ao carregar os dados da solicitação');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        getSolicitacao();
    }, [id]);

    const handleDecision = (tipo) => {
        setConfirmAction({ mostrar: true, tipo, mensagem: `Tem certeza que deseja ${tipo} esta adoção?` });
    };

    const confirmarDecision = async () => {
        try {
            if (confirmAction.tipo === 'aceitar') {
                await endFetch.put(`/solicitacaoadocao/${id}/aprovar`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
            } else {
                await endFetch.put(`/solicitacaoadocao/${id}/rejeitar`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
            }
            navigate('/Adocao'); 
        } catch (err) {
            console.error(err);
            setError('Erro ao processar a ação');
        }
    };

    const cancelarDecision = () => {
        setConfirmAction({ mostrar: false, tipo: '', mensagem: '' });
    };

    if (loading) return <div className={styles.carregando}>Carregando...</div>;
    if (error) return <div className={styles.erro}>{error}</div>;

    const animal = solicitacao.animal;
    const prop = solicitacao.proprietario;
    const cepGoogle = prop?.cep ? prop.cep.replace(/\D/g, '') : null;

    return (
        <>
            <Header />
            <div className={styles.vizualizar}>
                <Link to={'/Adocao'}><p className={styles.voltar}>Voltar</p></Link>
                <h1 className={styles.titulo}>Detalhes da Solicitação de Adoção</h1>

                <div className={styles.card}>
                    {/* Informações do Animal */}
                    <div className={styles.informacoes}>
                        <h3>Informações do Animal</h3>
                        <p><strong>ID:</strong> 
                            {animal ? <Link to={`/VisualizarAnimalAdotado/${animal.id}`}>{animal.id}</Link> : 'Não informado'}
                        </p>
                        <p><strong>Nome:</strong> {animal?.nome}</p>
                        <p><strong>Espécie:</strong> {animal?.especie}</p>
                        <p><strong>Idade:</strong> {animal?.idade} anos</p>
                    </div>

                    {/* Informações do Solicitante */}
                    <div className={styles.informacoes}>
                        <h3>Informações do Solicitante</h3>
                        <p><strong>Nome:</strong> {prop?.nome}</p>
                        <p><strong>Email:</strong> {prop?.email}</p>
                        <p><strong>Telefone:</strong> {prop?.telefone || 'Não informado'}</p>
                        <p><strong>CPF:</strong> {prop?.cpf}</p>
                        <p><strong>Endereço:</strong> {prop?.logradouro}, {prop?.numeroend || ''} {prop?.complemento || ''}, {prop?.bairro}, {prop?.uf}</p>
                        {cepGoogle && (
                            <p>
                                <a
                                    href={`https://www.google.com/maps/search/?api=1&query=${cepGoogle}`}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    Ver no mapa
                                </a>
                            </p>
                        )}
                    </div>

                    {/* Botões de ação */}
                    <div className={styles.botoes}>
                        <button className={botao.bgreen} onClick={() => handleDecision('aceitar')}>Aceitar</button>
                        <button className={botao.bred} onClick={() => handleDecision('recusar')}>Recusar</button>
                    </div>

                    {/* Confirmação */}
                    {confirmAction.mostrar && (
                        <div className={styles.confirmacao}>
                            <p>{confirmAction.mensagem}</p>
                            <button className={botao.bgreen} onClick={confirmarDecision}>Sim</button>
                            <button className={botao.bred} onClick={cancelarDecision}>Cancelar</button>
                        </div>
                    )}

                    {error && <div className={styles.erro}>{error}</div>}
                </div>
            </div>
        </>
    );
}
