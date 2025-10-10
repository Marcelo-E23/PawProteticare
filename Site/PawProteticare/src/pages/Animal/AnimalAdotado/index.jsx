import style from './animal.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';  
import { useNavigate } from 'react-router-dom';
import { FcSynchronize, FcBinoculars } from 'react-icons/fc';

export default function Animadotado() {
    const [animadotado, setAnimadotado] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    const getAnimadotado = async () => {
        try {
            const response = await endFetch.get("/animadotado"); 
            setAnimadotado(response.data);
            console.log(animadotado) 
        } catch (error) {
            console.error(<p className={style.erro}>Erro ao carregar os dados</p>, error);
        } finally {
            setLoading(false); 
        }
    };

    const navAlterar = (id) => {
        navigate(`/AlterarAnimalAdotado/${id}`);
    };

    const navVisualizar = (id) => {
        navigate(`/VisualizarAnimalAdotado/${id}`);
    };

    useEffect(() => {
        getAnimadotado();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {animadotado.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p >Sem animais cadastrados.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Espécie</th>
                                <th>Idade</th>
                                <th>Status</th>
                                <th>Necessidade de Protése</th>
                                <th className={style.alterar}><p>Alterar</p></th>
                                <th className={style.visualizar}><p>Visualizar</p></th>
                            </tr>
                        </thead>
                        <tbody>
                            {animadotado.map((animadotado) => (
                                <tr key={animadotado.id}>
                                    <td>{animadotado.id}</td>
                                    <td>{animadotado.nome}</td>
                                    <td>{animadotado.especie}</td>
                                    <td>{animadotado.idade} anos</td>
                                    <td>{animadotado.status}</td>
                                    <td>{animadotado.protese}</td>
                                    <td className={table.icon} onClick={() => navAlterar(animadotado.id)}>
                                        <FcSynchronize  size="3rem" />
                                    </td>
                                    <td className={table.icon} onClick={() => navVisualizar(animadotado.id)}>
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
