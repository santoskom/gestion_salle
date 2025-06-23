document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', () => {
        document.querySelectorAll('.nav-link').forEach(el => el.classList.remove('active'));
        link.classList.add('active');
    });
});

document.querySelectorAll('.has-submenu').forEach(item => {
    item.addEventListener('mouseenter', () => {
      item.querySelector('.submenu').style.display = 'block';
    });
  
    item.addEventListener('mouseleave', () => {
      item.querySelector('.submenu').style.display = 'none';
    });
  });