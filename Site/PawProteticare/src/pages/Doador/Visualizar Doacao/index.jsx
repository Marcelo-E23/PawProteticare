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
                setLoading(true);
                setErro('');
                
                // 1️⃣ Pegar a doação
                const responseDoacao = await endFetch.get(`/doacao/${id}`);
                const doacaoData = responseDoacao.data;
                console.log('Dados da doação:', doacaoData); // DEBUG
                
                setDoacao(doacaoData);

                // 2️⃣ Buscar dados do doador - múltiplas estratégias
                let doadorId = null;
                
                // Estratégia 1: Doador já vem completo no objeto
                if (doacaoData.doador && typeof doacaoData.doador === 'object') {
                    console.log('Doador já veio completo:', doacaoData.doador);
                    setDoador(doacaoData.doador);
                } 
                // Estratégia 2: Tem doador_id para buscar
                else if (doacaoData.doador_id) {
                    doadorId = doacaoData.doador_id;
                }
                // Estratégia 3: Doador como string/number direto
                else if (doacaoData.doador && (typeof doacaoData.doador === 'string' || typeof doacaoData.doador === 'number')) {
                    doadorId = doacaoData.doador;
                }
                // Estratégia 4: Verificar se tem ID do doador em outras propriedades
                else if (doacaoData.idDoador) {
                    doadorId = doacaoData.idDoador;
                }

                // Se identificou um ID do doador, busca os dados completos
                if (doadorId) {
                    console.log('Buscando doador com ID:', doadorId);
                    try {
                        const responseDoador = await endFetch.get(`/doador/${doadorId}`);
                        setDoador(responseDoador.data);
                    } catch (doadorError) {
                        console.warn('Erro ao buscar doador, tentando endpoint alternativo...');
                        // Tenta endpoint alternativo
                        try {
                            const responseDoadorAlt = await endFetch.get(`/usuario/${doadorId}`);
                            setDoador(responseDoadorAlt.data);
                        } catch (altError) {
                            console.warn('Não foi possível carregar dados completos do doador');
                        }
                    }
                }

            } catch (error) {
                console.error('Erro ao carregar doação:', error);
                setErro('Erro ao carregar dados da doação: ' + (error.response?.data?.message || error.message));
            } finally {
                setLoading(false);
            }
        };

        fetchDoacao();
    }, [id]);

    if (loading) return <div className={style.carregando}>Carregando...</div>;
    if (erro) return <div className={style.erro}>{erro}</div>;
    if (!doacao) return <div className={style.erro}>Doação não encontrada</div>;

    // Dados do doador com fallbacks
    const dadosDoador = doador || doacao.doador;
    const nomeDoador = dadosDoador?.nome || 
                      dadosDoador?.name || 
                      (typeof doacao.doador === 'string' ? doacao.doador : 'Não informado');

    return (
        <>
            <Header />
            <div className={style.visualizar}>
                <Voltar />
                <h1 className={style.titulo}>Detalhes da Doação</h1>

                <div className={style.card}>
                    <div className={style.informacoes}>
                        <h3>Informações da Doação</h3>
                        
                        <div className={style.dados}>
                            <p className={style.caracteristica}>ID da Doação</p>
                            <div className={style.valor}>{doacao.id}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Tipo de Doação</p>
                            <div className={style.valor}>{doacao.tipodoacao || doacao.tipoDoacao || doacao.tipo || '-'}</div>
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
                                    : doacao.dataDoacao
                                    ? new Date(doacao.dataDoacao).toLocaleDateString('pt-BR', {
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
                                    : 'R$ 0,00'}
                            </div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Descrição</p>
                            <div className={style.valor}>{doacao.descricao || doacao.descricaoDoacao || 'Não informada'}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Status</p>
                            <div className={style.valor}>{doacao.status || 'Não informado'}</div>
                        </div>
                    </div>

                    <div className={style.informacoes}>
                        <h3>Informações do Doador</h3>
                        
                        <div className={style.dados}>
                            <p className={style.caracteristica}>Nome</p>
                            <div className={style.valor}>{nomeDoador}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Email</p>
                            <div className={style.valor}>{dadosDoador?.email || dadosDoador?.mail || '-'}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>Telefone</p>
                            <div className={style.valor}>{dadosDoador?.telefone || dadosDoador?.phone || dadosDoador?.celular || '-'}</div>
                        </div>

                        <div className={style.dados}>
                            <p className={style.caracteristica}>CPF</p>
                            <div className={style.valor}>{dadosDoador?.cpf || dadosDoador?.documento || '-'}</div>
                        </div>

                        {dadosDoador && (dadosDoador.endereco || dadosDoador.logradouro) && (
                            <div className={style.dados}>
                                <p className={style.caracteristica}>Endereço</p>
                                <div className={style.valor}>
                                    {dadosDoador.logradouro || dadosDoador.endereco} {dadosDoador.numero || ''}
                                    {dadosDoador.complemento ? `, ${dadosDoador.complemento}` : ''}
                                    {dadosDoador.bairro ? `, ${dadosDoador.bairro}` : ''}
                                    {dadosDoador.cidade ? `, ${dadosDoador.cidade}` : ''}
                                    {dadosDoador.uf ? ` - ${dadosDoador.uf}` : ''}
                                    {dadosDoador.cep ? ` (CEP: ${dadosDoador.cep})` : ''}
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </>
    );
}