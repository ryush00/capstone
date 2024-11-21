// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Swal from 'sweetalert2'
window.Swal = Swal

document.addEventListener("turbo:before-cache", function () {
  if (window.ChannelIO) {
    ChannelIO('shutdown');
    delete window.ChannelIO;
    delete window.ChannelIOInitialized;
  }

  const script = document.querySelector('script[src*="channel.io"]');
  if (script) {
    script.parentNode.removeChild(script);
  }
  // 모든 모달 즉시 닫기
  document.querySelectorAll('.modal.show').forEach(modal => {
    modal.classList.remove('show');
    modal.style.display = ''; // display 스타일 초기화
    modal.removeAttribute('aria-modal');
    modal.setAttribute('aria-hidden', 'true');

    // 모달 인스턴스 dispose
    var modalInstance = bootstrap.Modal.getInstance(modal);
    if (modalInstance) {
      modalInstance.dispose();
    }

    // 모달 백드롭 제거
    document.querySelectorAll('.modal-backdrop').forEach(backdrop => {
      backdrop.remove();
    });
  });

  // 모든 오프캔버스 즉시 닫기
  document.querySelectorAll('.offcanvas.show').forEach(offcanvas => {
    offcanvas.classList.remove('show');
    offcanvas.style.visibility = ''; // visibility 스타일 초기화
    offcanvas.style.transform = ''; // transform 스타일 초기화
    offcanvas.setAttribute('aria-hidden', 'true');

    // 오프캔버스 인스턴스 dispose
    var offcanvasInstance = bootstrap.Offcanvas.getInstance(offcanvas);
    if (offcanvasInstance) {
      offcanvasInstance.dispose();
    }

    // 오프캔버스 백드롭 제거
    document.querySelectorAll('.offcanvas-backdrop').forEach(backdrop => {
      backdrop.remove();
    });
  });
});

document.addEventListener('turbo:load', function() {
  var triggers = document.querySelectorAll('.offcanvas-trigger');
  triggers.forEach(function(trigger) {
    trigger.addEventListener('click', function(event) {
      event.preventDefault();
      var targetId = trigger.getAttribute('href');
      var offcanvasElement = document.querySelector(targetId);
      if (offcanvasElement) {
        // 오프캔버스 인스턴스 생성 또는 가져오기
        var offcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasElement);
        offcanvas.show();
      }
    });
  });
});
