import style from './adocaoRejeitada.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';  
import { useNavigate } from 'react-router-dom';
import { FcBinoculars } from 'react-icons/fc';

export default function AdocoesRejeitadas() {
    const [adocoes, setAdocoes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [erro, setErro] = useState(null);
    const navigate = useNavigate();

    const getAdocoesRejeitadas = async () => {
        try {
            const response = await endFetch.get("/solicitacaoadocao?status=REJEITADO"); 
            setAdocoes(response.data);
        } catch (error) {
            console.error("Erro ao carregar os dados:", error);
            setAdocoes([]);
            setErro('Erro ao carregar os dados');
        } finally {
            setLoading(false);
        }
    };

    const navVisualizar = (id) => {
        navigate(`/VisualizarAdocao/${id}`);
    };

    useEffect(() => {
        getAdocoesRejeitadas();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {erro && <p className={style.erro}>{erro}</p>}

                {adocoes.length === 0 && !erro ? (
                    <div className={style.semcadastro}>
                        <p>Sem adoções rejeitadas.</p>
                    </div>
                ) : (
                    <table className="table table-danger table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Solicitante</th>
                                <th>Data</th>
                                <th>Animal</th>
                                <th className={style.visualizar}>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {adocoes.map((item) => (
                                <tr key={item.id}>
                                    <td>{item.id}</td>
                                    <td>{item.proprietario ? item.proprietario.nome : 'Não informado'}</td>
                                    <td>{new Date(item.data_solicitacao).toLocaleDateString()}</td>
                                    <td>{item.animal ? `${item.animal.nome} (${item.animal.idade} anos)` : 'Não informado'}</td>
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
