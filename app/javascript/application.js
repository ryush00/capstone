// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
  var triggers = document.querySelectorAll('.offcanvas-trigger');
  
  triggers.forEach(function(trigger) {
    // 이미 리스너가 등록되었는지 확인
    if (!trigger.dataset.listenerAdded) {
      trigger.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 동작 방지
        var targetId = trigger.getAttribute('href');
        var offcanvasElement = document.querySelector(targetId);

        if (offcanvasElement) {
          var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
          offcanvas.show();
        }
      });
      
      trigger.dataset.listenerAdded = 'true'; // 리스너가 추가되었음을 표시
    }
  });
});
