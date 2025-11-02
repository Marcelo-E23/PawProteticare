import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import endFetch from '../../../axios';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import style from './visualizardoacao.module.css';

export default function VisualizarDoacao() {
    const { id } = useParams();
    const [doacao, setDoacao] = useState(null);
    const [doador, setDoador] = useState(null);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState('');

    useEffect(() => {
        const fetchDoacao = async () => {
            try {
                // 1️⃣ Pegar a doação
                const responseDoacao = await endFetch.get(`/doacao/${id}`);
                const doacaoData = responseDoacao.data;
                setDoacao(doacaoData);

                // 2️⃣ Se tiver doador_id, buscar dados completos do doador
                if (doacaoData.doador?.id) {
                    const responseDoador = await endFetch.get(`/doador/${doacaoData.doador.id}`);
                    setDoador(responseDoador.data);
                }
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
    if (!doacao) return <div className={style.erro}>Doação não encontrada</div>;

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
                            <p className={style.caracteristica}>Tipo de Doação</p>
                            <div className={style.valor}>{doacao.tipodoacao || '-'}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Data</p>
                            <div className={style.valor}>
                                {doacao.datadoacao
                                    ? new Date(doacao.datadoacao).toLocaleDateString('pt-BR', {
                                          day: '2-digit',
                                          month: '2-digit',
                                          year: 'numeric'
                                      })
                                    : '-'}
                            </div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Valor</p>
                            <div className={style.valor}>
                                {doacao.valor
                                    ? parseFloat(doacao.valor).toLocaleString('pt-BR', {
                                          style: 'currency',
                                          currency: 'BRL'
                                      })
                                    : '-'}
                            </div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Doador</p>
                            <div className={style.valor}>
                                <p><strong>Nome:</strong> {doador?.nome || doacao.doador.nome}</p>
                                <p><strong>Email:</strong> {doador?.email || '-'}</p>
                                <p><strong>Telefone:</strong> {doador?.telefone || '-'}</p>
                            </div>
                        </div>
                        </div>
                        </div>
                    </div>
        </>
    );
}
