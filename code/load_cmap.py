def load_cmap(cmap_name='batlow', preview=False):
    """
    Load a ScientificColourMaps6 colormap from .txt file.
    To reverse the colormap, append a '-' after the colormap name, e.g., 'batlow-'.
    More info about ScientificColourMaps: http://www.fabiocrameri.ch/colourmaps.php
    """
    import numpy as np
    import matplotlib.pyplot as plt
    from matplotlib.colors import LinearSegmentedColormap
    
    _scm6_dir = 'shared-ns1000k/GEO4962/scripts/ScientificColourMaps6'
    _scm6_dir = 'ScientificColourMaps6'
    
    if cmap_name.endswith('-'):
        _name = cmap_name.rstrip('-') # remove '-' from colormap name
        _file_name = f'{_scm6_dir}/{_name}/{_name}.txt'
        _cmap_data = np.flipud(np.loadtxt(_file_name)) # and reverse colormap
    else:
        _name = cmap_name
        _file_name = f'{_scm6_dir}/{_name}/{_name}.txt'
        _cmap_data = np.loadtxt(_file_name)

    cmap = LinearSegmentedColormap.from_list(cmap_name, _cmap_data)
        
    if preview==True:
        x = np.linspace(0, 100, 100)[None, :]
        plt.imshow(x, aspect='auto',cmap=cmap);
    
    return cmap
