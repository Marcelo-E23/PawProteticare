import Header from '../../../components/Header';
import table from '../../../css/table.module.css';
import style from './doador.module.css';
import endFetch from '../../../axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { FcBinoculars } from 'react-icons/fc';
import botao from '../../../css/botao.module.css';
import Voltar from '../../../components/Voltar';

export default function Doacao() {
    const [doacoes, setDoacoes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState(null);
    const navigate = useNavigate();

    const getDoacoes = async () => {
        try {
            setLoading(true);
            setErro(null);
            
            const response = await endFetch.get("/doacao");
            console.log('Dados recebidos:', response.data); // DEBUG
            
            // Processa os dados para garantir estrutura consistente
            const doacoesProcessadas = response.data.map(item => ({
                ...item,
                // Normaliza o nome do doador
                doadorNome: item.doador?.nome || 
                           item.doador?.name || 
                           (typeof item.doador === 'string' ? item.doador : 'Não informado'),
                // Normaliza a data
                dataFormatada: item.data ? new Date(item.data) : 
                              item.datadoacao ? new Date(item.datadoacao) :
                              item.dataDoacao ? new Date(item.dataDoacao) : null,
                // Normaliza o valor
                valorNumerico: parseFloat(item.valor) || 0
            }));
            
            setDoacoes(doacoesProcessadas);
        } catch (error) {
            console.error("Erro ao carregar doações:", error);
            setErro("Erro ao carregar os dados: " + (error.response?.data?.message || error.message));
        } finally {
            setLoading(false);
        }
    };

    const navVisualizar = (id) => navigate(`/VisualizarDoacao/${id}`);

    useEffect(() => {
        getDoacoes();
    }, []);

    // Função para formatar data
    const formatarData = (data) => {
        if (!data) return 'Não informado';
        return data.toLocaleDateString('pt-BR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    };

    // Função para formatar valor
    const formatarValor = (valor) => {
        return valor.toLocaleString('pt-BR', { 
            style: 'currency', 
            currency: 'BRL' 
        });
    };

    return (
        <>
            <Header />
            <div className={style.container}>
                <Voltar />
                <div className={table.tabela}>
                    {loading ? (
                        <div className={style.carregando}>
                            <div className="spinner-border text-success" role="status">
                                <span className="visually-hidden">Carregando...</span>
                            </div>
                            <p className={style.textoCarregando}>Carregando doações...</p>
                        </div>
                    ) : erro ? (
                        <div className={style.erro}>
                            <p>{erro}</p>
                        </div>
                    ) : doacoes.length === 0 ? (
                        <div className={style.semcadastro}>
                            <p>Nenhuma doação registrada.</p>
                            <button 
                                className={botao.bprimary} 
                                onClick={getDoacoes}
                            >
                                Recarregar
                            </button>
                        </div>
                    ) : (
                        <>
                            <table className="table table-success table-striped-columns">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Doador</th>
                                        <th>Data</th>
                                        <th>Valor</th>
                                        <th>Tipo</th>
                                        <th className={style.visualizar}>Visualizar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {doacoes.map((item) => (
                                        <tr key={item.id}>
                                            <td>{item.id}</td>
                                            <td>{item.doadorNome}</td>
                                            <td>{formatarData(item.dataFormatada)}</td>
                                            <td>{formatarValor(item.valorNumerico)}</td>
                                            <td>{item.tipodoacao || item.tipoDoacao || item.tipo || '-'}</td>
                                            <td 
                                                className={table.icon} 
                                                onClick={() => navVisualizar(item.id)}
                                                title="Visualizar detalhes"
                                            >
                                                <FcBinoculars size="2rem" />
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </>
                    )}
                </div>
            </div>
        </>
    );
}