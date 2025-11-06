import style from './adocaoRejeitada.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';
import { useNavigate, Link } from 'react-router-dom';
import { FcBinoculars } from 'react-icons/fc';
import Voltar from '../../../components/Voltar';

export default function AdocoesRejeitadas() {
    const [adocoes, setAdocoes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState(null);
    const navigate = useNavigate();

    const getAdocoesRejeitadas = async () => {
        try {
            setLoading(true);
            setErro(null);
            
            const response = await endFetch.get("/solicitacao-adocao");
            console.log('Dados completos da API:', response.data); // DEBUG
            
            const apenasRejeitadas = response.data.filter(item => {
                // Verificação mais robusta do status
                const status = item.status?.toString().trim().toUpperCase();
                console.log(`Item ${item.id}: status = "${item.status}" -> "${status}"`); // DEBUG
                return status === 'REPROVADO' || status === 'REJEITADO' || status === 'RECUSADO';
            });
            
            console.log('Adoções rejeitadas filtradas:', apenasRejeitadas); // DEBUG
            setAdocoes(apenasRejeitadas);
            
        } catch (error) {
            console.error("Erro ao carregar os dados:", error);
            setErro('Erro ao carregar os dados: ' + (error.response?.data?.message || error.message));
        } finally {
            setLoading(false);
        }
    };

    const navVisualizar = (id) => {
        navigate(`/VisualizarAdocao/${id}`);
    };

    // Função para debug - mostra a estrutura dos dados
    const debugDataStructure = (data) => {
        if (data.length > 0) {
            console.log('Estrutura do primeiro item:', Object.keys(data[0]));
            console.log('Dados do primeiro item:', data[0]);
            if (data[0].proprietario) {
                console.log('Estrutura do proprietario:', Object.keys(data[0].proprietario));
            }
            if (data[0].animachado) {
                console.log('Estrutura do animachado:', Object.keys(data[0].animachado));
            }
        }
    };

    useEffect(() => {
        getAdocoesRejeitadas();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    if (erro) {
        return (
            <>
                <Header />
                <Voltar />
                <div className={style.erro}>{erro}</div>
            </>
        );
    }

    return (
        <>
            <Header />
            <Voltar />
            <div className={table.tabela}>
                {adocoes.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Nenhuma adoção rejeitada encontrada</p>
                    </div>
                ) : (
                    <table className="table table-danger table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Solicitante</th>
                                <th>Data</th>
                                <th>Animal</th>
                                <th>Status</th>
                                <th className={style.visualizar}>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {adocoes.map((item) => (
                                <tr key={item.id}>
                                    <td>{item.id}</td>
                                    <td>
                                        {item.proprietario?.nome || 
                                         item.solicitante?.nome || 
                                         'Não informado'}
                                    </td>
                                    <td>
                                        {item.dataSolicitacao ? new Date(item.dataSolicitacao).toLocaleDateString() :
                                         item.data_solicitacao ? new Date(item.data_solicitacao).toLocaleDateString() :
                                         'Data não informada'}
                                    </td>
                                    <td>
                                        {item.animachado?.nome ||
                                         item.animal?.nome ||
                                         item.nomeAnimal ||
                                         'Não informado'}
                                    </td>
                                    <td>{item.status}</td>
                                    <td className={table.icon} onClick={() => navVisualizar(item.id)}>
                                        <FcBinoculars size="3rem" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </>
    );
}