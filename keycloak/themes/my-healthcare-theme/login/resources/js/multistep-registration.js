// Multi-step Registration Form Handler
(function() {
    'use strict';
    
    let currentStep = 1;
    const totalSteps = 3;

    function showStep(step) {
        const steps = document.querySelectorAll('.form-step');
        steps.forEach(s => s.style.display = 'none');
        
        const currentStepElement = document.querySelector(`.form-step[data-step="${step}"]`);
        if (currentStepElement) {
            currentStepElement.style.display = 'block';
        }
        
        updateProgressIndicator(step);
        updateButtons(step);
    }

    function updateProgressIndicator(step) {
        const indicators = document.querySelectorAll('.step-indicator');
        indicators.forEach((indicator, index) => {
            const stepNum = index + 1;
            const circle = indicator.querySelector('.step-circle');
            
            if (stepNum < step) {
                indicator.classList.add('completed');
                indicator.classList.remove('active');
                circle.style.background = '#10b981';
                circle.style.color = 'white';
            } else if (stepNum === step) {
                indicator.classList.add('active');
                indicator.classList.remove('completed');
                circle.style.background = '#0891b2';
                circle.style.color = 'white';
            } else {
                indicator.classList.remove('active', 'completed');
                circle.style.background = '#e5e7eb';
                circle.style.color = '#9ca3af';
            }
        });
        
        const progressBar = document.getElementById('progress-bar');
        if (progressBar) {
            const progress = ((step - 1) / (totalSteps - 1)) * 100;
            progressBar.style.width = progress + '%';
        }
    }

    function updateButtons(step) {
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const submitBtn = document.getElementById('submitBtn');
        
        if (!prevBtn || !nextBtn || !submitBtn) return;
        
        prevBtn.style.display = step === 1 ? 'none' : 'block';
        
        if (step === totalSteps) {
            nextBtn.style.display = 'none';
            submitBtn.style.display = 'block';
        } else {
            nextBtn.style.display = 'block';
            submitBtn.style.display = 'none';
        }
    }

    function validateStep(step) {
        const currentStepElement = document.querySelector(`.form-step[data-step="${step}"]`);
        if (!currentStepElement) return true;
        
        const inputs = currentStepElement.querySelectorAll('input[required], select[required]');
        let isValid = true;
        
        inputs.forEach(input => {
            if (!input.value.trim()) {
                isValid = false;
                input.style.borderColor = '#ef4444';
            } else {
                input.style.borderColor = '#e5e7eb';
            }
        });
        
        if (step === 1) {
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const passwordConfirm = document.getElementById('password-confirm');
            
            if (email && email.value) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email.value)) {
                    email.style.borderColor = '#ef4444';
                    alert('Please enter a valid email address');
                    return false;
                }
            }
            
            if (password && passwordConfirm) {
                if (password.value !== passwordConfirm.value) {
                    passwordConfirm.style.borderColor = '#ef4444';
                    alert('Passwords do not match');
                    return false;
                }
            }
        }
        
        if (!isValid) {
            alert('Please fill in all required fields');
        }
        
        return isValid;
    }

    function changeStep(direction) {
        if (direction === 1 && !validateStep(currentStep)) {
            return;
        }
        
        const newStep = currentStep + direction;
        
        if (newStep >= 1 && newStep <= totalSteps) {
            currentStep = newStep;
            showStep(currentStep);
        }
    }

    // Expose changeStep globally
    window.changeStep = changeStep;

    // Initialize
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            showStep(1);
        });
    } else {
        showStep(1);
    }
})();