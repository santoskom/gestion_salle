document.addEventListener('DOMContentLoaded', function() {
    const dateInputs = document.querySelectorAll('input[type="datetime-local"]');
    
    dateInputs.forEach(input => {
        let lastValue = input.value;
        
        input.addEventListener('input', function() {
            if (this.value !== lastValue) {
                this.blur();
                lastValue = this.value;
            }
        });
        
        input.addEventListener('change', function() {
            this.blur();
        });
    });
});



