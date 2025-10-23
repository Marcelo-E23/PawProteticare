import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './visualizardoacao.module.css';

export default function VisualizarDoacao() {
    const { id } = useParams();
    const [doacao, setDoacao] = useState(null);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState('');

    useEffect(() => {
        const fetchDoacao = async () => {
            const token = localStorage.getItem('access_token');
            try {
                const response = await endFetch.get(`/doacao/${id}`);
                setDoacao(response.data);
            } catch (error) {
                console.error(error);
                setErro('Erro ao carregar dados da doação');
            } finally {
                setLoading(false);
            }
        };
        fetchDoacao();
    }, [id]);

    if (loading) return <div className={style.carregando}>Carregando...</div>;
    if (erro) return <div className={style.erro}>{erro}</div>;

    return (
        <>
            <Header />
            <div className={style.visualizar}>
                <Link to="/Doacao"><Voltar /></Link>
                <h1 className={style.titulo}>Detalhes da Doação</h1>

                <div className={style.card}>
                    <div className={style.informacoes}>
                        <div className={style.dados}>
                            <p className={style.caracteristica}>ID da Doação</p>
                            <div className={style.valor}>{doacao.id}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Valor</p>
                            <div className={style.valor}>R$ {doacao.valor.toFixed(2)}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Data</p>
                            <div className={style.valor}>{new Date(doacao.data).toLocaleDateString()}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Doador</p>
                            <div className={style.valor}>
                                {doacao.doador ? (
                                    <>
                                        <p><strong>Nome:</strong> {doacao.doador.nome}</p>
                                        <p><strong>Email:</strong> {doacao.doador.email}</p>
                                        <p><strong>Telefone:</strong> {doacao.doador.telefone}</p>
                                    </>
                                ) : 'Não informado'}
                            </div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Observações</p>
                            <div className={style.valor}>{doacao.observacoes || '-'}</div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}
