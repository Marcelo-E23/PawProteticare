import style from './animal.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';  
import { useNavigate } from 'react-router-dom';
import { FcSynchronize, FcBinoculars } from 'react-icons/fc';
import botao from '../../../css/botao.module.css'

export default function Animachado() {
    const [animachado, setAnimachado] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        const getAnimachado = async () => {
            try {
                const response = await endFetch.get("/animachado");
                setAnimachado(response.data)
                console.log("dados recebidos:", response.data);
            } catch (error) {
                console.error(error);
            } finally {
                setLoading(false); 
            }
        };
        getAnimachado();
    }, []);

    const navCadastro = () => navigate('/CadastroAnimalAchado');
    const navAlterar = (id) => navigate(`/AlterarAnimaLAchado/${id}`);
    const navVisualizar = (id) => navigate(`/VisualizarAnimalAchado/${id}`);
    const navAdotado = () => navigate('/AnimalAdotado');

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {animachado.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Sem animais cadastrados.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Espécie</th>
                                <th>Idade</th>
                                <th>Protése</th>
                                <th>Status</th>
                                <th className={style.alterar}>Alterar</th>
                                <th className={style.visualizar}>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>
                            {animachado.map((animal) => (
                                <tr key={animal.id}>
                                    <td>{animal.id}</td>
                                    <td>{animal.nome}</td>
                                    <td>{animal.especie}</td>
                                    <td>{animal.idade}</td>
                                    <td>{animal.proteseEntity?.nome || '—'}</td>
                                    <td>{animal.status}</td>
                                    <td>
                                        <button 
                                            className={botao.borange} 
                                            onClick={() => navAlterar(animal.id)}
                                        >
                                            <FcSynchronize size={20} />
                                        </button>
                                    </td>
                                    <td>
                                        <button 
                                            className={botao.bblue} 
                                            onClick={() => navVisualizar(animal.id)}
                                        >
                                            <FcBinoculars size={20} />
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
                <button type="button" className={botao.bgreen} onClick={navCadastro}>
                    Inserir
                </button>
                <button type="button" className={botao.bblue} onClick={navAdotado}>
                    Adotados
                </button>
            </div>
        </>
    );
}
